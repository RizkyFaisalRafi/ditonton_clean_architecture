import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([TvDetailNotifier, TvDetailBloc])
void main() {
  // MockTvDetailBloc instance
  late MockTvDetailBloc mockTvDetailBloc;

  /// Set up mock before each test
  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
  });

  /// Helper function to create a testable widget with mocked dependencies
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: MaterialApp(home: body),
    );
  }

  void arrangeBlocState(TvDetailState state) {
    when(mockTvDetailBloc.state).thenReturn(state);
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.value(state));
  }

  const tId = 1;

  // Sample TV Detail data for testing
  // final testTvDetail = TvDetail(
  //   adult: false,
  //   backdropPath: '/backdropPath.jpg',
  //   createdBy: [
  //     CreatedBy(
  //       id: 1,
  //       creditId: "creditId",
  //       name: "Creator 1",
  //       originalName: "originalName",
  //       gender: 1,
  //       profilePath: "profilePath",
  //     ),
  //   ],
  //   episodeRunTime: [1],
  //   firstAirDate: 'firstAirDate',
  //   genres: [Genre(id: 1, name: 'Action')],
  //   homepage: 'homepage',
  //   id: 1,
  //   inProduction: false,
  //   lastAirDate: 'lastAirDate',
  //   lastEpisodeToAir: EpisodeToAir(
  //     id: 1,
  //     name: 'name',
  //     overview: 'overview',
  //     voteAverage: 1.0,
  //     voteCount: 1,
  //     airDate: 'airDate',
  //     episodeNumber: 1,
  //     episodeType: 'episodeType',
  //     productionCode: 'productionCode',
  //     runtime: 1,
  //     seasonNumber: 1,
  //     showId: 1,
  //     stillPath: 'stillPath',
  //   ),
  //   name: 'Lapor Pak',
  //   nextEpisodeToAir: EpisodeToAir(
  //     id: 1,
  //     name: 'name',
  //     overview: 'overview',
  //     voteAverage: 1.0,
  //     voteCount: 1,
  //     airDate: 'airDate',
  //     episodeNumber: 1,
  //     episodeType: 'episodeType',
  //     productionCode: 'productionCode',
  //     runtime: 1,
  //     seasonNumber: 1,
  //     showId: 1,
  //     stillPath: 'stillPath',
  //   ),
  //   numberOfEpisodes: 1,
  //   numberOfSeasons: 1,
  //   overview: 'overview',
  //   popularity: 100.0,
  //   posterPath: 'posterPath',
  //   productionCompanies: [
  //     ProductionCompanies(
  //       id: 1,
  //       logoPath: 'logoPath',
  //       name: 'name',
  //       originCountry: 'originCountry',
  //     ),
  //   ],
  //   seasons: [
  //     Season(
  //       airDate: 'airDate',
  //       episodeCount: 10,
  //       id: 1,
  //       name: 'Season 1',
  //       overview: 'overview',
  //       posterPath: 'posterPath',
  //       seasonNumber: 1,
  //       voteAverage: 1.0,
  //     ),
  //   ],
  //   status: 'status',
  //   voteAverage: 9.5,
  //   voteCount: 1,
  // );

  group('Tv Detail Page', () {
    /// Initial
    testWidgets('should display progress indicator when state is initial', (
      widgetTester,
    ) async {
      // Arrange
      arrangeBlocState(const TvDetailState.initialTvDetail());

      // Act
      await widgetTester.pumpWidget(
        makeTestableWidget(const TvSeriesDetailPage(id: tId)),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byKey(Key('initialState')), findsOneWidget);
    });

    /// Loading
    testWidgets('should display lottie loading when state is loading', (
      widgetTester,
    ) async {
      // Arrange
      arrangeBlocState(const TvDetailState.loadingTvDetail());

      // Act
      await widgetTester.pumpWidget(
        makeTestableWidget(TvSeriesDetailPage(id: tId)),
      );

      // Assert
      expect(find.byType(Lottie), findsOneWidget);
    });

    /// Loaded DetailContent & Recommendation
    testWidgets('should display DetailContent when state is loaded', (
      widgetTester,
    ) async {
      // Arrange
      arrangeBlocState(
        TvDetailState.loadedTvDetail(
          tvDetail: testTvDetail,
          tvRecommendations: testTvList,
          recommendationState: RequestState.loaded,
          isAddedToWatchlist: false,
        ),
      );

      // Act
      await mockNetworkImages(() async {
        await widgetTester.pumpWidget(
          makeTestableWidget(TvSeriesDetailPage(id: tId)),
        );
      });

      // Assert
      expect(find.byType(DetailContents), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Season Information'), findsOneWidget);
      expect(find.byKey(Key('LoadedState Recommendation')), findsOneWidget);
    });

    /// Error
    testWidgets('should display ErrorStateWidget when state is error', (
      widgetTester,
    ) async {
      // Arrange
      arrangeBlocState(const TvDetailState.errorTvDetail('Failed to load data'));

      // Act
      await widgetTester.pumpWidget(
        makeTestableWidget(TvSeriesDetailPage(id: tId)),
      );

      // Assert
      expect(find.byType(ErrorStateWidget2), findsOneWidget);
      expect(find.text('Failed to load data'), findsOneWidget);
    });

    /// Loaded - AddToWatchlist event is tapped
    testWidgets(
      'should call AddToWatchlist event when watchlist button is tapped and not in watchlist',
      (WidgetTester tester) async {
        // Arrange
        arrangeBlocState(
          TvDetailState.loadedTvDetail(
            tvDetail: testTvDetail,
            tvRecommendations: const [],
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: false,
          ),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesDetailPage(id: tId)),
          );
        });

        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        // Assert
        verify(
          mockTvDetailBloc.add(TvDetailEvent.addToWatchlist(testTvDetail)),
        );
      },
    );

    /// Loaded - RemoveFromWatchlist event is tapped
    testWidgets(
      'should call RemoveFromWatchlist event when watchlist button is tapped and already in watchlist',
      (WidgetTester tester) async {
        // Arrange
        arrangeBlocState(
          TvDetailState.loadedTvDetail(
            tvDetail: testTvDetail,
            tvRecommendations: [],
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: true,
          ),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesDetailPage(id: tId)),
          );
        });

        expect(find.byIcon(Icons.check), findsOneWidget);
        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        // Assert
        verify(
          mockTvDetailBloc.add(TvDetailEvent.removeFromWatchlist(testTvDetail)),
        );
      },
    );

    /// Loaded - Show Snackbar Added to Watchlist
    testWidgets(
      'should show SnackBar when watchlist message is a success message',
      (WidgetTester tester) async {
        // Arrange
        arrangeBlocState(
          TvDetailState.loadedTvDetail(
            tvDetail: testTvDetail,
            tvRecommendations: [],
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: false,
          ),
        );

        // Simulasikan stream state yang berubah
        when(mockTvDetailBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([
            TvDetailState.loadedTvDetail(
              tvDetail: testTvDetail,
              tvRecommendations: [],
              recommendationState: RequestState.loaded,
              isAddedToWatchlist: true,
              watchlistMessage: 'Added to Watchlist',
            ),
          ]),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            makeTestableWidget(const TvSeriesDetailPage(id: tId)),
          );
          await tester.pump();
        });

        // Assert
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      },
    );
  });

  // group('Tv Series Detail Page Test', () {
  //   /// Test 1: Loading State
  //   testWidgets('Should display loading indicator when state is Loading', (
  //     widgetTester,
  //   ) async {
  //     /// Arrange
  //     when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loading);
  //
  //     /// Act
  //     await widgetTester.pumpWidget(
  //       makeTestableWidget(TvSeriesDetailPage(id: 1)),
  //     );
  //
  //     /// Assert
  //     expect(find.byKey(Key('loading_tv_detail')), findsOneWidget);
  //   });
  //
  //   /// Test 2: Error State
  //   testWidgets('Should display error message when state is Error', (
  //     WidgetTester tester,
  //   ) async {
  //     /// Arrange
  //     when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Error);
  //     when(mockTvDetailNotifier.message).thenReturn('Error');
  //
  //     /// Act
  //     await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
  //
  //     /// Assert
  //     expect(find.text('Error'), findsOneWidget);
  //   });
  //
  //   /// Test 3: Loaded State - Content Verification
  //   testWidgets('Should display all content when state is Loaded', (
  //     WidgetTester tester,
  //   ) async {
  //     /// Arrange
  //     when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
  //     when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
  //     when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
  //     when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
  //     when(
  //       mockTvDetailNotifier.recommendationState,
  //     ).thenReturn(RequestState.Loaded);
  //
  //     /// Act & Assert
  //     await mockNetworkImages(() async {
  //       // Wrap with mockNetworkImages
  //       await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
  //       await tester.pump();
  //
  //       expect(find.text('Lapor Pak'), findsOneWidget); // Name Tv Series
  //       expect(find.text('Overview'), findsOneWidget); // Overview
  //       expect(find.text('Action'), findsOneWidget); // genres Action
  //       expect(find.byType(RatingBarIndicator), findsOneWidget);
  //       expect(find.text('9.5'), findsOneWidget); // Vote Average
  //       expect(find.text('Popularity: '), findsOneWidget); // Popularity
  //       expect(find.text('100.0'), findsOneWidget); // Popularity Count
  //       expect(find.text('Created by'), findsOneWidget); // Created by
  //       expect(find.text('Creator 1'), findsOneWidget); // Name Created By
  //       expect(find.text('Season Information'), findsOneWidget);
  //       expect(find.text('Season 1'), findsOneWidget); // Name Season
  //       expect(
  //         find.text('10 episodes'),
  //         findsOneWidget,
  //       ); // Season Information Episode Count
  //       expect(find.text('Last Episode'), findsOneWidget);
  //       expect(find.text('Recommendations Tv Series'), findsOneWidget);
  //     });
  //   });
  //
  //   /// Test 4: Watchlist Button - Add Icon
  //   testWidgets(
  //     'Watchlist button should display add icon when Tv Series not added to watchlist',
  //     (WidgetTester tester) async {
  //       /// Arrange
  //       when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
  //       when(
  //         mockTvDetailNotifier.recommendationState,
  //       ).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
  //       when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
  //       final watchlistButtonIcon = find.byIcon(Icons.add);
  //
  //       /// Act & Assert
  //       await mockNetworkImages(() async {
  //         await tester.pumpWidget(
  //           makeTestableWidget(TvSeriesDetailPage(id: 1)),
  //         );
  //         expect(watchlistButtonIcon, findsOneWidget);
  //       });
  //     },
  //   );
  //
  //   /// Test 5: Watchlist Button - Check Icon
  //   testWidgets(
  //     'Watchlist button should dispay check icon when Tv Series is added to wathclist',
  //     (WidgetTester tester) async {
  //       /// Arrange
  //       when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
  //       when(
  //         mockTvDetailNotifier.recommendationState,
  //       ).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
  //       when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(true);
  //
  //       final watchlistButtonIcon = find.byIcon(Icons.check);
  //
  //       /// Act
  //       await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
  //
  //       /// Assert
  //       expect(watchlistButtonIcon, findsOneWidget);
  //     },
  //   );
  //
  //   /// Test 6: Watchlist Button - Success Case
  //   testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //       // Inisialisasi watchlistButton
  //       final watchlistButton = find.byType(FilledButton);
  //
  //       /// Arrange
  //       when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
  //       when(
  //         mockTvDetailNotifier.recommendationState,
  //       ).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
  //       when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
  //       when(
  //         mockTvDetailNotifier.watchlistMessage,
  //       ).thenReturn('Added to Watchlist');
  //       when(
  //         mockTvDetailNotifier.addWatchlist(testTvDetail),
  //       ).thenAnswer((_) async {});
  //
  //       /// Act
  //       // Build widget
  //       await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
  //       // Tap button
  //       await tester.ensureVisible(watchlistButton);
  //       await tester.tap(watchlistButton);
  //       await tester.pump();
  //
  //       /// Assert
  //       verify(mockTvDetailNotifier.addWatchlist(testTvDetail)).called(1);
  //       expect(find.byType(SnackBar), findsOneWidget);
  //       expect(find.text('Added to Watchlist'), findsOneWidget);
  //     },
  //   );
  //
  //   /// Test 7: Watchlist Button - Failure Case
  //   testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //       // Inisialisasi watchlistButton
  //       final watchlistButton = find.byType(FilledButton);
  //
  //       /// Arrange
  //       when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
  //       when(
  //         mockTvDetailNotifier.recommendationState,
  //       ).thenReturn(RequestState.Loaded);
  //       when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
  //       when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
  //       when(mockTvDetailNotifier.watchlistMessage).thenReturn('Failed');
  //       when(
  //         mockTvDetailNotifier.addWatchlist(testTvDetail),
  //       ).thenAnswer((_) async {});
  //
  //       /// Act
  //       // Build widget
  //       await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
  //       // Tap button
  //       await tester.ensureVisible(watchlistButton);
  //       await tester.tap(watchlistButton);
  //       await tester.pump();
  //
  //       /// Assert
  //       verify(mockTvDetailNotifier.addWatchlist(testTvDetail)).called(1);
  //       expect(find.byType(AlertDialog), findsOneWidget);
  //       expect(find.text('Failed'), findsOneWidget);
  //     },
  //   );
  // });
}
