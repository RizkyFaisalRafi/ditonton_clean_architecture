import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/genre.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/created_by.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/episode_to_air.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/production_companies.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/season.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  // Mock TV Detail Notifier instance
  late MockTvDetailNotifier mockTvDetailNotifier;

  // Sample TV Detail data for testing
  final testTvDetail = TvDetail(
    adult: false,
    backdropPath: '/backdropPath.jpg',
    createdBy: [
      CreatedBy(
        id: 1,
        creditId: "creditId",
        name: "Creator 1",
        originalName: "originalName",
        gender: 1,
        profilePath: "profilePath",
      ),
    ],
    episodeRunTime: [1],
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: false,
    lastAirDate: 'lastAirDate',
    lastEpisodeToAir: EpisodeToAir(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1.0,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    name: 'Lapor Pak',
    nextEpisodeToAir: EpisodeToAir(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1.0,
      voteCount: 1,
      airDate: 'airDate',
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    ),
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: 'overview',
    popularity: 100.0,
    posterPath: 'posterPath',
    productionCompanies: [
      ProductionCompanies(
        id: 1,
        logoPath: 'logoPath',
        name: 'name',
        originCountry: 'originCountry',
      ),
    ],
    seasons: [
      Season(
        airDate: 'airDate',
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
        voteAverage: 1.0,
      ),
    ],
    status: 'status',
    voteAverage: 9.5,
    voteCount: 1,
  );

  /// Helper function to create a testable widget with mocked dependencies
  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockTvDetailNotifier,
      child: MaterialApp(home: body),
    );
  }

  /// Set up mock before each test
  setUp(() {
    mockTvDetailNotifier = MockTvDetailNotifier();
  });

  group('Tv Series Detail Page Test', () {
    /// Test 1: Loading State
    testWidgets('Should display loading indicator when state is Loading', (
      widgetTester,
    ) async {
      /// Arrange
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loading);

      /// Act
      await widgetTester.pumpWidget(
        makeTestableWidget(TvSeriesDetailPage(id: 1)),
      );

      /// Assert
      expect(find.byKey(Key('loading_tv_detail')), findsOneWidget);
    });

    /// Test 2: Error State
    testWidgets('Should display error message when state is Error', (
      WidgetTester tester,
    ) async {
      /// Arrange
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Error);
      when(mockTvDetailNotifier.message).thenReturn('Error');

      /// Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));

      /// Assert
      expect(find.text('Error'), findsOneWidget);
    });

    /// Test 3: Loaded State - Content Verification
    testWidgets('Should display all content when state is Loaded', (
      WidgetTester tester,
    ) async {
      /// Arrange
      when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
      when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
      when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
      when(
        mockTvDetailNotifier.recommendationState,
      ).thenReturn(RequestState.Loaded);

      /// Act & Assert
      await mockNetworkImages(() async {
        // Wrap with mockNetworkImages
        await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
        await tester.pump();

        expect(find.text('Lapor Pak'), findsOneWidget); // Name Tv Series
        expect(find.text('Overview'), findsOneWidget); // Overview
        expect(find.text('Action'), findsOneWidget); // genres Action
        expect(find.byType(RatingBarIndicator), findsOneWidget);
        expect(find.text('9.5'), findsOneWidget); // Vote Average
        expect(find.text('Popularity: '), findsOneWidget); // Popularity
        expect(find.text('100.0'), findsOneWidget); // Popularity Count
        expect(find.text('Created by'), findsOneWidget); // Created by
        expect(find.text('Creator 1'), findsOneWidget); // Name Created By
        expect(find.text('Season Information'), findsOneWidget);
        expect(find.text('Season 1'), findsOneWidget); // Name Season
        expect(
          find.text('10 episodes'),
          findsOneWidget,
        ); // Season Information Episode Count
        expect(find.text('Last Episode'), findsOneWidget);
        expect(find.text('Recommendations Tv Series'), findsOneWidget);
      });
    });

    /// Test 4: Watchlist Button - Add Icon
    testWidgets(
      'Watchlist button should display add icon when Tv Series not added to watchlist',
      (WidgetTester tester) async {
        /// Arrange
        when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
        when(
          mockTvDetailNotifier.recommendationState,
        ).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
        when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
        final watchlistButtonIcon = find.byIcon(Icons.add);

        /// Act & Assert
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            makeTestableWidget(TvSeriesDetailPage(id: 1)),
          );
          expect(watchlistButtonIcon, findsOneWidget);
        });
      },
    );

    /// Test 5: Watchlist Button - Check Icon
    testWidgets(
      'Watchlist button should dispay check icon when Tv Series is added to wathclist',
      (WidgetTester tester) async {
        /// Arrange
        when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
        when(
          mockTvDetailNotifier.recommendationState,
        ).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
        when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(true);

        final watchlistButtonIcon = find.byIcon(Icons.check);

        /// Act
        await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));

        /// Assert
        expect(watchlistButtonIcon, findsOneWidget);
      },
    );

    /// Test 6: Watchlist Button - Success Case
    testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
        // Inisialisasi watchlistButton
        final watchlistButton = find.byType(FilledButton);

        /// Arrange
        when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
        when(
          mockTvDetailNotifier.recommendationState,
        ).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
        when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
        when(
          mockTvDetailNotifier.watchlistMessage,
        ).thenReturn('Added to Watchlist');
        when(
          mockTvDetailNotifier.addWatchlist(testTvDetail),
        ).thenAnswer((_) async {});

        /// Act
        // Build widget
        await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
        // Tap button
        await tester.ensureVisible(watchlistButton);
        await tester.tap(watchlistButton);
        await tester.pump();

        /// Assert
        verify(mockTvDetailNotifier.addWatchlist(testTvDetail)).called(1);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      },
    );

    /// Test 7: Watchlist Button - Failure Case
    testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
        // Inisialisasi watchlistButton
        final watchlistButton = find.byType(FilledButton);

        /// Arrange
        when(mockTvDetailNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvDetail).thenReturn(testTvDetail);
        when(
          mockTvDetailNotifier.recommendationState,
        ).thenReturn(RequestState.Loaded);
        when(mockTvDetailNotifier.tvRecommendations).thenReturn([testTvSeries]);
        when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockTvDetailNotifier.watchlistMessage).thenReturn('Failed');
        when(
          mockTvDetailNotifier.addWatchlist(testTvDetail),
        ).thenAnswer((_) async {});

        /// Act
        // Build widget
        await tester.pumpWidget(makeTestableWidget(TvSeriesDetailPage(id: 1)));
        // Tap button
        await tester.ensureVisible(watchlistButton);
        await tester.tap(watchlistButton);
        await tester.pump();

        /// Assert
        verify(mockTvDetailNotifier.addWatchlist(testTvDetail)).called(1);
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      },
    );
  });
}
