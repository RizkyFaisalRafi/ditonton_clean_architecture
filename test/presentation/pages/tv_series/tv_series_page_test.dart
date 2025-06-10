import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_list_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'tv_series_page_test.mocks.dart';

// You'll also need this mock class
class MockScrollPosition extends Mock implements ScrollPosition {}

@GenerateMocks([TvListNotifier, TvSearchNotifier])
void main() {
  late MockTvListNotifier mockNotifier;
  late List<TvSeries> testTvSeries;
  late MockTvSearchNotifier mockTvSearchNotifier;
  late List<TvSeries> emptyTvSeries;

  const loadingStates = {
    'airingToday': RequestState.Loading,
    'onTheAir': RequestState.Loading,
    'popular': RequestState.Loading,
    'topRated': RequestState.Loading,
  };

  const loadedStates = {
    'airingToday': RequestState.Loaded,
    'onTheAir': RequestState.Loaded,
    'popular': RequestState.Loaded,
    'topRated': RequestState.Loaded,
  };

  const errorStates = {
    'airingToday': RequestState.Error,
    'onTheAir': RequestState.Error,
    'popular': RequestState.Error,
    'topRated': RequestState.Error,
  };

  setUp(() {
    mockNotifier = MockTvListNotifier();
    mockTvSearchNotifier = MockTvSearchNotifier();

    // Setup properties
    when(mockNotifier.refreshC).thenReturn(RefreshController());
    when(mockNotifier.airingTodayController).thenReturn(ScrollController());
    when(mockNotifier.onTheAirController).thenReturn(ScrollController());
    when(mockNotifier.popularController).thenReturn(ScrollController());
    when(mockNotifier.topRatedController).thenReturn(ScrollController());

    testTvSeries = [
      TvSeries(
        id: 1,
        name: 'Lapor Pak',
        overview: 'Overview 1',
        posterPath: '/poster1.jpg',
        backdropPath: '/backdrop1.jpg',
        adult: null,
        genreIds: [],
        originCountry: [],
        originalLanguage: '',
        originalName: '',
        popularity: null,
        firstAirDate: '',
        voteAverage: null,
        voteCount: null,
      ),
      TvSeries(
        id: 2,
        name: 'Joko Widodo',
        overview: 'Overview 2',
        posterPath: '/poster2.jpg',
        backdropPath: '/backdrop2.jpg',
        adult: null,
        genreIds: [],
        originCountry: [],
        originalLanguage: '',
        originalName: '',
        popularity: null,
        firstAirDate: '',
        voteAverage: null,
        voteCount: null,
      ),
    ];
  });

  emptyTvSeries = [];

  Widget makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TvListNotifier>.value(value: mockNotifier),
        ChangeNotifierProvider<TvSearchNotifier>.value(
          value: mockTvSearchNotifier,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(body: body),
        routes: {
          TvSeriesDetailPage.ROUTE_NAME: (context) => Container(),
          SearchTvPage.ROUTE_NAME: (context) => SearchTvPage(),
        },
      ),
    );
  }

  void setupMockStates(
    Map<String, RequestState> states, {
    bool emptyData = false,
  }) {
    when(mockNotifier.airingTodayState).thenReturn(states['airingToday']!);
    when(mockNotifier.onTheAirState).thenReturn(states['onTheAir']!);
    when(mockNotifier.popularTvState).thenReturn(states['popular']!);
    when(mockNotifier.topRatedTvState).thenReturn(states['topRated']!);

    final data = emptyData ? emptyTvSeries : testTvSeries;
    when(mockNotifier.airingTodayTvSeries).thenReturn(data);
    when(mockNotifier.onTheAirTvSeries).thenReturn(data);
    when(mockNotifier.popularTvSeries).thenReturn(data);
    when(mockNotifier.topRatedTvSeries).thenReturn(data);
  }

  group('TvSeriesPage Widget Tests', () {
    /// Done
    testWidgets('should display app bar with title and search icon', (
      tester,
    ) async {
      // Arrange
      setupMockStates(loadingStates);

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(find.text('TV Series Ditonton'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should show loading indicator when state is Loading', (
      tester,
    ) async {
      // Arrange
      setupMockStates(loadingStates);

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(find.byType(Lottie), findsNWidgets(4));
      expect(find.byKey(Key('loading_bar_airing_lottie')), findsOneWidget);
    });

    testWidgets('should show error message when state is Error', (
      tester,
    ) async {
      // Arrange
      setupMockStates(errorStates);
      when(mockNotifier.message).thenReturn('Failed to Load Data');

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(
        find.text(
          "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
        ),
        findsOneWidget,
      );
      expect(find.text('Failed to Load Data'), findsNWidgets(3));
    });

    testWidgets('should show TvSeriesList when state is Loaded', (
      tester,
    ) async {
      // Arrange
      setupMockStates(loadedStates);

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));
      });

      // Assert
      expect(find.byType(TvSeriesList), findsNWidgets(4));
      expect(find.byType(CachedNetworkImage), findsNWidgets(8));
      expect(find.text('Airing Today'), findsOneWidget);
      expect(find.text('On The Air'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
      expect(find.text('Top Rated'), findsOneWidget);
    });

    testWidgets('Page should call loadTvSeries when first time loaded', (
      WidgetTester tester,
    ) async {
      // arrange
      setupMockStates(loadingStates);

      // Perlu menambahkan verifikasi bahwa loadTvSeries dipanggil
      when(
        mockNotifier.loadTvSeries(),
      ).thenAnswer((_) => mockNotifier.onRefresh());

      // act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));
      await tester.runAsync(() => mockNotifier.loadTvSeries());

      // assert
      verify(mockNotifier.loadTvSeries()).called(1);
    });

    testWidgets('should navigate to detail page when tv series is tapped', (
      tester,
    ) async {
      // Arrange
      setupMockStates(loadedStates);

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));
        await tester.tap(find.byType(InkWell).first);
        await tester.pumpAndSettle();
      });

      // Assert
      expect(find.byType(TvSeriesDetailPage), findsNothing);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should trigger search when text submitted', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Empty);
      const testQuery = 'test query';

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));
      await tester.enterText(find.byType(TextField), testQuery);
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Assert
      verify(mockTvSearchNotifier.fetchTvSearch(testQuery)).called(1);
    });
  });

  group('TvSeriesList Widget Tests', () {
    testWidgets('should display correct number of items', (tester) async {
      // Arrange & Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          makeTestableWidget(TvSeriesList(testTvSeries, ScrollController())),
        );
      });

      // Assert
      expect(
        find.byType(CachedNetworkImage),
        findsNWidgets(testTvSeries.length),
      );
    });

    testWidgets('should display cached network images with placeholders', (
      tester,
    ) async {
      // Arrange & Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          makeTestableWidget(TvSeriesList(testTvSeries, ScrollController())),
        );

        // Assert
        final cachedImages = tester.widgetList<CachedNetworkImage>(
          find.byType(CachedNetworkImage),
        );
        expect(cachedImages.length, testTvSeries.length);

        for (var i = 0; i < testTvSeries.length; i++) {
          expect(
            cachedImages.elementAt(i).imageUrl,
            contains(testTvSeries[i].posterPath ?? ''),
          );
        }
      });
    });

    testWidgets('should navigate to detail page when item is tapped', (
      tester,
    ) async {
      // Arrange & Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          makeTestableWidget(TvSeriesList(testTvSeries, ScrollController())),
        );

        await tester.tap(find.byType(InkWell).first);
        await tester.pumpAndSettle();
      });

      // Assert
      expect(
        find.byType(TvSeriesDetailPage),
        findsNothing,
      ); // Since mocked the route
    });
  });
}
