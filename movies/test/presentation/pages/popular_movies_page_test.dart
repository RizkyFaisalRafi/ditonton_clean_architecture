import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movies/module/movies.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/test_helper_movie.mocks.dart';

void main() {
  // late MockPopularMoviesNotifier mockNotifier;
  late MockSeeMorePopularMovieBloc mockSeeMorePopularMovieBloc;

  setUp(() {
    mockSeeMorePopularMovieBloc = MockSeeMorePopularMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeeMorePopularMovieBloc>.value(
      value: mockSeeMorePopularMovieBloc,
      child: MaterialApp(home: body),
    );
  }

  void arrangeBlocState(SeeMorePopularMovieState state) {
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
      arrangeBlocState(
        const SeeMorePopularMovieState.loadingPopularMSeeMore(),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

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
    arrangeBlocState(
      SeeMorePopularMovieState.loadedPopularMSeeMore(
        popular: testMovieList,
        popularPage: 1,
        hasMorePopular: false,
      ),
    );

    // Act
    await mockNetworkImages(() async {
      await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));
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
      arrangeBlocState(
        const SeeMorePopularMovieState.loadedPopularMSeeMore(
          popular: [],
          popularPage: 1,
          hasMorePopular: false,
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

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
      arrangeBlocState(
        SeeMorePopularMovieState.errorPopularMSeeMore(
          'Failed to connect to the network',
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));
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
    arrangeBlocState(
      const SeeMorePopularMovieState.errorPopularMSeeMore('Server Error'),
    );

    // Act
    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));
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
      arrangeBlocState(
        const SeeMorePopularMovieState.errorPopularMSeeMore('Server Failure'),
      );

      await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

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
          const SeeMorePopularMovieEvent.refreshPopularMovies(),
        ),
      ).called(1);
    },
  );
}
