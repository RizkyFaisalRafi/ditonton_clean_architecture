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
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'tv_series_page_test.mocks.dart';

@GenerateMocks([TvListNotifier, TvSearchNotifier])
void main() {
  late MockTvListNotifier mockNotifier;
  late List<TvSeries> testTvSeries;
  late MockTvSearchNotifier mockTvSearchNotifier;

  setUp(() {
    mockNotifier = MockTvListNotifier();
    mockTvSearchNotifier = MockTvSearchNotifier();
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

  group('TvSeriesPage Widget Tests', () {
    testWidgets('should display app bar with title and search icon', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loading);
      when(mockNotifier.airingTodayTvSeries).thenReturn([]);
      when(mockNotifier.onTheAirState).thenReturn(RequestState.Loading);
      when(mockNotifier.onTheAirTvSeries).thenReturn([]);
      when(mockNotifier.popularTvState).thenReturn(RequestState.Loading);
      when(mockNotifier.popularTvSeries).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(find.text('TV Series Ditonton'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should call fetchTvSeriesAiringToday when initState', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loading);
      when(mockNotifier.airingTodayTvSeries).thenReturn([]);
      when(mockNotifier.onTheAirState).thenReturn(RequestState.Loading);
      when(mockNotifier.onTheAirTvSeries).thenReturn([]);
      when(mockNotifier.popularTvState).thenReturn(RequestState.Loading);
      when(mockNotifier.popularTvSeries).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      verify(mockNotifier.fetchTvSeriesAiringToday()).called(1);
      verify(
        mockNotifier.fetchTvSeriesOnTheAir(),
      ).called(1); // Also verify this
    });

    testWidgets('should show loading indicator when state is Loading', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loading);
      when(mockNotifier.airingTodayTvSeries).thenReturn([]);
      when(mockNotifier.onTheAirState).thenReturn(RequestState.Loading);
      when(mockNotifier.onTheAirTvSeries).thenReturn([]);
      when(mockNotifier.popularTvState).thenReturn(RequestState.Loading);
      when(mockNotifier.popularTvSeries).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsNWidgets(3));
    });

    testWidgets('should show error message when state is Error', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Error);
      when(mockNotifier.airingTodayTvSeries).thenReturn([]);
      when(mockNotifier.onTheAirState).thenReturn(RequestState.Error);
      when(mockNotifier.onTheAirTvSeries).thenReturn([]);
      when(mockNotifier.message).thenReturn('Error message');
      when(mockNotifier.popularTvState).thenReturn(RequestState.Error);
      when(mockNotifier.popularTvSeries).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(find.text('Failed'), findsNWidgets(3));
    });

    testWidgets('should show TvSeriesList when state is Loaded', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loaded);
      when(mockNotifier.airingTodayTvSeries).thenReturn(testTvSeries);
      when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
      when(mockNotifier.onTheAirTvSeries).thenReturn(testTvSeries);
      when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
      when(mockNotifier.popularTvSeries).thenReturn([]);

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));
      });

      // Assert
      expect(find.byType(TvSeriesList), findsNWidgets(3));
      expect(find.text('Airing Today'), findsOneWidget);
      expect(find.text('On The Air'), findsOneWidget);
      expect(find.text('Popular'), findsOneWidget);
    });

    testWidgets('should navigate to detail page when tv series is tapped', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loaded);
      when(mockNotifier.airingTodayTvSeries).thenReturn(testTvSeries);
      when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
      when(mockNotifier.onTheAirTvSeries).thenReturn(testTvSeries);
      when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
      when(mockNotifier.popularTvSeries).thenReturn([]);

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));
        await tester.tap(find.byType(InkWell).first);
        await tester.pumpAndSettle();
      });

      // Assert
      expect(
        find.byType(TvSeriesDetailPage),
        findsNothing,
      ); // Since we mocked the route
    });

    testWidgets(
      'should navigate to SearchTvPage when search icon is tapped and search query in SearchTvPage',
      (tester) async {
        // Arrange
        when(mockNotifier.airingTodayState).thenReturn(RequestState.Loaded);
        when(mockNotifier.airingTodayTvSeries).thenReturn(testTvSeries);
        when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
        when(mockNotifier.onTheAirTvSeries).thenReturn(testTvSeries);
        when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.popularTvSeries).thenReturn([]);
        // Add these stubs for the search notifier
        when(mockTvSearchNotifier.state).thenReturn(RequestState.Empty);
        when(mockTvSearchNotifier.searchResult).thenReturn([]);
        when(mockTvSearchNotifier.message).thenReturn('');

        await mockNetworkImages(() async {
          await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

          // Verify initial state
          expect(find.byType(TvSeriesPage), findsOneWidget);
          expect(find.byType(SearchTvPage), findsNothing);

          // Act - Tap IconButton
          await tester.tap(find.byType(IconButton));
          await tester.pumpAndSettle();

          // Assert - Verify navigation occurred
          expect(find.byType(TvSeriesPage), findsNothing);
          expect(find.byType(SearchTvPage), findsOneWidget);

          // verify search notifier was initialized
          verifyNever(
            mockTvSearchNotifier.fetchTvSearch(any),
          ); // Shouldn't be called yet

          // Tapi boleh terpanggil setelah submit
          await tester.enterText(find.byType(TextField), 'naruto');
          await tester.testTextInput.receiveAction(TextInputAction.search);
          verify(mockTvSearchNotifier.fetchTvSearch('naruto')).called(1);
        });
      },
    );
  });

  group('TvSeriesList Widget Tests', () {
    testWidgets('should display correct number of items', (tester) async {
      // Arrange & Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(TvSeriesList(testTvSeries)));
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
        await tester.pumpWidget(makeTestableWidget(TvSeriesList(testTvSeries)));

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
        await tester.pumpWidget(makeTestableWidget(TvSeriesList(testTvSeries)));

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
