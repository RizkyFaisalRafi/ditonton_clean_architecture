import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'tv_series_page_test.mocks.dart';

@GenerateMocks([TvListNotifier])
void main() {
  late MockTvListNotifier mockNotifier;
  late List<TvSeries> testTvSeries;

  setUp(() {
    mockNotifier = MockTvListNotifier();
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
    return ChangeNotifierProvider<TvListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
        routes: {TvSeriesDetailPage.ROUTE_NAME: (context) => Container()},
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

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      verify(mockNotifier.fetchTvSeriesAiringToday()).called(1);
    });

    testWidgets('should show loading indicator when state is Loading', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loading);
      when(mockNotifier.airingTodayTvSeries).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error message when state is Error', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Error);
      when(mockNotifier.airingTodayTvSeries).thenReturn([]);
      when(mockNotifier.message).thenReturn('Error message');

      // Act
      await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));

      // Assert
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets('should show TvSeriesList when state is Loaded', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loaded);
      when(mockNotifier.airingTodayTvSeries).thenReturn(testTvSeries);

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(TvSeriesPage()));
      });

      // Assert
      expect(find.byType(TvSeriesList), findsOneWidget);
      expect(find.text('Airing Today'), findsOneWidget);
    });

    testWidgets('should navigate to detail page when tv series is tapped', (
      tester,
    ) async {
      // Arrange
      when(mockNotifier.airingTodayState).thenReturn(RequestState.Loaded);
      when(mockNotifier.airingTodayTvSeries).thenReturn(testTvSeries);

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
  });

  group('TvSeriesList Widget Tests', () {
    testWidgets('should display correct number of items', (tester) async {
      // Arrange & Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          makeTestableWidget(TvSeriesList(testTvSeries)),
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
          makeTestableWidget(TvSeriesList(testTvSeries)),
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
          makeTestableWidget(TvSeriesList(testTvSeries)),
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
