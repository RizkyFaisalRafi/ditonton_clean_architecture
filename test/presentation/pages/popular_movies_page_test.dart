import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/see_more_popular/see_more_popular_movie_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier, SeeMorePopularMovieBloc])
void main() {
  late MockPopularMoviesNotifier mockNotifier;
  late MockSeeMorePopularMovieBloc mockSeeMorePopularMovieBloc;

  setUp(() {
    mockNotifier = MockPopularMoviesNotifier();
    // Setup properties
    when(mockNotifier.refreshC).thenReturn(RefreshController());
    when(mockNotifier.scrollController).thenReturn(ScrollController());

    mockSeeMorePopularMovieBloc = MockSeeMorePopularMovieBloc();
  });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<PopularMoviesNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(home: body),
  //   );
  // }

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeeMorePopularMovieBloc>.value(
      value: mockSeeMorePopularMovieBloc,
      child: MaterialApp(home: body),
    );
  }

  void _arrangeBlocState(SeeMorePopularMovieState state) {
    when(mockSeeMorePopularMovieBloc.state).thenReturn(state);
    when(
      mockSeeMorePopularMovieBloc.stream,
    ).thenAnswer((_) => Stream.value(state));
  }

  /// Loading
  testWidgets(
    'Page should display Lottie loading indicator when state is Loading',
    (WidgetTester tester) async {
      // Arrange
      _arrangeBlocState(const SeeMorePopularMovieState.loading());

      // Act
      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      // Assert
      final progressBarFinder = find.byKey(Key('loading_popular_movie'));
      final lottieFinder = find.byType(Lottie);
      expect(progressBarFinder, findsOneWidget);
      expect(lottieFinder, findsOneWidget);
    },
  );

  /// Loaded
  testWidgets('Page should display ListView when state is Loaded with data', (
    WidgetTester tester,
  ) async {
    // Arrange
    _arrangeBlocState(
      SeeMorePopularMovieState.loaded(
        popular: testMovieList,
        popularPage: 1,
        hasMorePopular: false,
      ),
    );

    // Act
    await mockNetworkImages(() async {
      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
      await tester.pump();
      // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
      // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
      await tester.pump(const Duration(seconds: 1));
    });

    // Assert
    final listViewFinder = find.byKey(const Key('loaded_popular'));
    final smartRefresherFinder = find.byType(SmartRefresher);

    expect(smartRefresherFinder, findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(listViewFinder, findsOneWidget);
  });

  /// Loaded - Empty Data List
  testWidgets(
    'Page should display EmptyStateWidget when state is Loaded but data is empty',
    (WidgetTester tester) async {
      // Arrange
      _arrangeBlocState(
        const SeeMorePopularMovieState.loaded(
          popular: [],
          popularPage: 1,
          hasMorePopular: false,
        ),
      );

      // Act
      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      // Assert
      final emptyMessageFinder = find.text(
        'There are no popular movies at the moment',
      );
      expect(emptyMessageFinder, findsOneWidget);
    },
  );

  /// No Internet
  testWidgets(
    'Page should display No Internet error message when state is Error with network message',
    (WidgetTester tester) async {
      // Arrange
      _arrangeBlocState(
        SeeMorePopularMovieState.error('Failed to connect to the network'),
      );

      // Act
      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
      await tester.pump(); // pump again to ensure the state propagates

      // Assert
      final errorMessageFinder = find.text('No Internet Connection!');
      expect(errorMessageFinder, findsOneWidget);
      final lottieFinder = find.byType(Lottie);
      expect(lottieFinder, findsOneWidget);
    },
  );

  /// Other Error
  testWidgets('Page should display ErrorStateWidget2 for other errors', (
    WidgetTester tester,
  ) async {
    // Arrange
    _arrangeBlocState(const SeeMorePopularMovieState.error('Server Error'));

    // Act
    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));
    await tester.pump(); // pump again to ensure the state propagates

    // Assert
    final errorMessageFinder = find.text('Server Error');
    expect(errorMessageFinder, findsOneWidget);
  });

  /// Error - Trigger Refresh
  testWidgets(
    'Page should dispatch refreshMovies event when retry button is pressed on error state',
    (WidgetTester tester) async {
      // Arrange
      _arrangeBlocState(const SeeMorePopularMovieState.error('Server Failure'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      // Ensure the error widget is visible
      final errorMessageFinder = find.text('Server Failure');
      expect(errorMessageFinder, findsOneWidget);

      // This test assumes your ErrorStateWidget2 contains an ElevatedButton for retry.
      final retryButtonFinder = find.byType(ElevatedButton);
      expect(retryButtonFinder, findsOneWidget);

      // Act
      // Simulate tapping the retry button
      await tester.tap(retryButtonFinder);
      await tester.pump(); // Let the UI react to the tap

      final errorWidgetFinder = find.byType(ErrorStateWidget2);

      // Assert
      expect(errorWidgetFinder, findsOneWidget);
      // Verify that the 'add' method on the BLoC was called exactly once
      // with the refreshMovies event.
      verify(
        mockSeeMorePopularMovieBloc.add(
          const SeeMorePopularMovieEvent.refreshMovies(),
        ),
      ).called(1);
    },
  );
}
