import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/watchlist_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/watchlist_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'watchlist_tv_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<WatchlistTvNotifier>(),
  MockSpec<NavigatorObserver>(),
  MockSpec<Route>(),
])
void main() {
  late MockWatchlistTvNotifier mockNotifier;
  late MockNavigatorObserver mockObserver;
  late List<TvSeries> testTvSeries;

  setUp(() {
    mockNotifier = MockWatchlistTvNotifier();
    mockObserver = MockNavigatorObserver();
  });

  testTvSeries = [
    TvSeries(
      id: 1,
      name: 'Test TV 1',
      overview: 'Overview 1',
      posterPath: '/poster1.jpg',
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
    TvSeries(
      id: 2,
      name: 'Test TV 2',
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

  Widget makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WatchlistTvNotifier>.value(value: mockNotifier),
      ],
      child: MaterialApp(
        home: body,
        navigatorObservers: [mockObserver],
        onGenerateRoute: (settings) {
          if (settings.name == TvSeriesDetailPage.ROUTE_NAME) {
            return MaterialPageRoute(
              builder: (_) => Scaffold(),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }

  group('WatchlistTvPage', () {
    testWidgets('should display app bar with title', (tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);
      when(mockNotifier.watchlistTv).thenReturn([]);

      await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

      expect(find.text('Watchlist TV'), findsOneWidget);
    });

    testWidgets('should call fetchWatchlistTv when initState', (tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);
      when(mockNotifier.watchlistTv).thenReturn([]);

      await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

      verify(mockNotifier.fetchWatchlistTv()).called(1);
    });

    testWidgets('should show loading indicator when state is Loading', (
      tester,
    ) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loading);
      when(mockNotifier.watchlistTv).thenReturn([]);

      await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when state is Error', (
      tester,
    ) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Error);
      when(mockNotifier.watchlistTv).thenReturn([]);
      when(mockNotifier.message).thenReturn('Error message');

      await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

      expect(find.text('Error message'), findsOneWidget);
      expect(find.byKey(Key('error_message')), findsOneWidget);
    });

    testWidgets('should show list of tv series when state is Loaded', (
      tester,
    ) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
      when(mockNotifier.watchlistTv).thenReturn(testTvSeries);

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));
      });

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(InkWell), findsNWidgets(3));
    });

    testWidgets('should navigate to detail page when tv series is tapped', (
      tester,
    ) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.Loaded);
      when(mockNotifier.watchlistTv).thenReturn(testTvSeries);

      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(WatchlistTvPage()));

        await tester.tap(find.byType(InkWell).first);
        await tester.pumpAndSettle();

        verify(mockObserver.didPush(any, any)).called(lessThanOrEqualTo(2));
      });
    });
  });

  group('MovieCardTv', () {
    testWidgets('should display tv series information correctly', (
      tester,
    ) async {
      final testTv = testTvSeries[0];

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          makeTestableWidget(Scaffold(body: MovieCardTv(testTv))),
        );

        expect(find.text(testTv.name!), findsOneWidget);
        expect(find.text(testTv.overview!), findsOneWidget);
        expect(find.byType(CachedNetworkImage), findsOneWidget);
      });
    });

    testWidgets('should show placeholder while loading image', (tester) async {
      final testTv = testTvSeries[0];

      await tester.pumpWidget(
        makeTestableWidget(Scaffold(body: MovieCardTv(testTv))),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should navigate to detail when tapped', (tester) async {
      final testTv = testTvSeries[0];

      await mockNetworkImages(() async {
        await tester.pumpWidget(
          makeTestableWidget(Scaffold(body: MovieCardTv(testTv))),
        );

        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();

        verify(mockObserver.didPush(any, any)).called(lessThanOrEqualTo(2));
      });
    });
  });
}
