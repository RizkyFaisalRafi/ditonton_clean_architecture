import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/see_more_popular/see_more_popular_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([SeeMorePopularTvBloc])
void main() {
  late MockSeeMorePopularTvBloc mockSeeMorePopularTvBloc;

  setUp(() {
    // Setup properties
    mockSeeMorePopularTvBloc = MockSeeMorePopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeeMorePopularTvBloc>.value(
      value: mockSeeMorePopularTvBloc,
      child: MaterialApp(home: body),
    );
  }

  void _arrangeBlocState(SeeMorePopularTvState state) {
    when(mockSeeMorePopularTvBloc.state).thenReturn(state);
    when(
      mockSeeMorePopularTvBloc.stream,
    ).thenAnswer((_) => Stream.value(state));
  }

  /// Loading
  testWidgets(
    'Page should display Lottie loading indicator when state is Loading',
    (WidgetTester tester) async {
      // Arrange
      _arrangeBlocState(const SeeMorePopularTvState.loading());

      // Act
      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      // Assert
      final progressBarFinder = find.byKey(Key('loading_popular_tv'));
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
      SeeMorePopularTvState.loaded(
        popularTv: testTvList,
        popularTvPage: 1,
        hasMorePopularTv: false,
      ),
    );

    // Act
    await mockNetworkImages(() async {
      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));
      await tester.pump();
      // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
      // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
      await tester.pump(const Duration(seconds: 1));
    });

    // Assert
    final listViewFinder = find.byKey(const Key('loaded_popular_tv'));
    final smartRefresherFinder = find.byType(SmartRefresher);

    expect(find.byType(TvCard), findsOneWidget);
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
        const SeeMorePopularTvState.loaded(
          popularTv: [],
          popularTvPage: 1,
          hasMorePopularTv: false,
        ),
      );

      // Act
      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      // Assert
      final emptyMessageFinder = find.text(
        'There are no popular tv at the moment',
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
        SeeMorePopularTvState.error('Failed to connect to the network'),
      );

      // Act
      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));
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
    _arrangeBlocState(const SeeMorePopularTvState.error('Server Error'));

    // Act
    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));
    await tester.pump(); // pump again to ensure the state propagates

    // Assert
    final errorMessageFinder = find.text('Server Error');
    expect(errorMessageFinder, findsOneWidget);
  });

  /// Error - Trigger Refresh
  testWidgets(
    'Page should dispatch refreshTv event when retry button is pressed on error state',
    (WidgetTester tester) async {
      // Arrange
      _arrangeBlocState(const SeeMorePopularTvState.error('Server Failure'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

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
        mockSeeMorePopularTvBloc.add(const SeeMorePopularTvEvent.refreshTv()),
      ).called(1);
    },
  );
}
