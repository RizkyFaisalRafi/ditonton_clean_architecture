import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:core/module/core.dart';

// @GenerateMocks([SeeMoreOnTheAirTvBloc])
void main() {
  late MockSeeMoreOnTheAirTvBloc mockSeeMoreOnTheAirTvBloc;

  setUp(() {
    mockSeeMoreOnTheAirTvBloc = MockSeeMoreOnTheAirTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SeeMoreOnTheAirTvBloc>.value(
      value: mockSeeMoreOnTheAirTvBloc,
      child: MaterialApp(home: body),
    );
  }

  void arrangeBlocState(SeeMoreOnTheAirTvState state) {
    when(mockSeeMoreOnTheAirTvBloc.state).thenReturn(state);
    when(
      mockSeeMoreOnTheAirTvBloc.stream,
    ).thenAnswer((_) => Stream.value(state));
  }

  /// Loading
  testWidgets(
    'Page should display Lottie loading indicator when state is Loading',
    (WidgetTester tester) async {
      // Arrange
      arrangeBlocState(const SeeMoreOnTheAirTvState.loadingOnTheAirTSeeMore());

      // Act
      await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));

      // Assert
      final progressBarFinder = find.byKey(Key('loading_on_the_air_tv'));
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
      SeeMoreOnTheAirTvState.loadedOnTheAirTSeeMore(
        onTheAir: testTvList,
        onTheAirPage: 1,
        hasMoreOnTheAir: false,
      ),
    );

    // Act
    await mockNetworkImages(() async {
      await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));
      await tester.pump();
      // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
      // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
      await tester.pump(const Duration(seconds: 1));
    });

    // Assert
    final listViewFinder = find.byKey(const Key('loaded_on_the_air'));
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
      arrangeBlocState(
        const SeeMoreOnTheAirTvState.loadedOnTheAirTSeeMore(
          onTheAir: [],
          onTheAirPage: 1,
          hasMoreOnTheAir: false,
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));

      // Assert
      final emptyMessageFinder = find.text(
        'There are no on the air tv at the moment',
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
        SeeMoreOnTheAirTvState.errorOnTheAirTSeeMore(
          'Failed to connect to the network',
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));
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
      const SeeMoreOnTheAirTvState.errorOnTheAirTSeeMore('Server Error'),
    );

    // Act
    await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));
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
      arrangeBlocState(
        const SeeMoreOnTheAirTvState.errorOnTheAirTSeeMore('Server Failure'),
      );

      await tester.pumpWidget(makeTestableWidget(OnTheAirTvPage()));

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
        mockSeeMoreOnTheAirTvBloc.add(
          const SeeMoreOnTheAirTvEvent.refreshOnTheAirTv(),
        ),
      ).called(1);
    },
  );
}
