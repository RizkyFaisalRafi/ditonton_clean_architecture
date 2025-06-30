import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  final tTvSeriesWithNulls = TvSeries(
    adult: false,
    backdropPath: null,
    genreIds: const [],
    id: 1,
    // Name null untuk tes fallback '-'
    name: null,
    // Overview null untuk tes fallback '-'
    overview: null,
    popularity: 0,
    // Poster path null untuk tes error widget
    posterPath: null,
    firstAirDate: null,
    originalName: null,
    originalLanguage: null,
    originCountry: [],
    voteAverage: 0,
    voteCount: 0,
  );

  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    // Inisialisasi mock
    mockNavigatorObserver = MockNavigatorObserver();
    // (FIX) Stubbing untuk .navigator pada objek yang benar
    when(mockNavigatorObserver.navigator).thenReturn(null);
  });

  // Helper widget yang lebih robust, menyertakan Scaffold
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      theme: ThemeData(textTheme: TextTheme(titleLarge: kHeading6)),
      home: Scaffold(body: body),
      navigatorObservers: [mockNavigatorObserver],
      // Gunakan onGenerateRoute untuk menangani argumen dengan lebih baik
      onGenerateRoute: (settings) {
        if (settings.name == tvSeriesDetailRoute) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(body: Text('Tv Detail Page')),
            settings: settings, // Teruskan settings untuk memeriksa argumen
          );
        }
        return null;
      },
    );
  }

  group('TvCard Widget Tests', () {
    testWidgets('should display TV title and overview correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeTestableWidget(TvCard(tv: testTvSeries)));

      // Act & Assert
      // Pastikan teks judul sesuai dengan tMovie.title
      expect(find.text('Gute Zeiten, schlechte Zeiten'), findsOneWidget);
      expect(find.text(testTvSeries.overview!), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('should display "-" when name and overview are null', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        makeTestableWidget(TvCard(tv: tTvSeriesWithNulls)),
      );

      // Act & Assert
      expect(find.text('-'), findsNWidgets(2));
    });

    testWidgets(
      'should display CachedNetworkImage with correct imageUrl and placeholder',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(makeTestableWidget(TvCard(tv: testTvSeries)));

        // Act
        final cachedNetworkImageFinder = find.byType(CachedNetworkImage);
        expect(cachedNetworkImageFinder, findsOneWidget);
        final cachedNetworkImage = tester.widget<CachedNetworkImage>(
          cachedNetworkImageFinder,
        );

        // Assert
        expect(
          cachedNetworkImage.imageUrl,
          '$baseImageUrl${testTvSeries.posterPath}',
        );
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'should display error icon when posterPath is null or image fails to load',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          makeTestableWidget(TvCard(tv: tTvSeriesWithNulls)),
        );

        await tester.pumpAndSettle();

        // Assert that the error icon is present and the circular progress indicator is gone.
        expect(find.byIcon(Icons.error), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    testWidgets('should navigate to TvSeriesDetailPage when tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeTestableWidget(TvCard(tv: testTvSeries)));

      // Bersihkan interaksi setelah render awal, sebelum aksi tap
      clearInteractions(mockNavigatorObserver);

      // Act
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Assert
      // captureAny akan menangkap argumen yang dikirim saat didPush dipanggil
      final verification = verify(
        mockNavigatorObserver.didPush(captureAny, any),
      );

      // Verifikasi bahwa navigasi terjadi setidaknya sekali
      verification.called(1);

      final capturedRoute = verification.captured.first as Route;
      expect(capturedRoute.settings.name, tvSeriesDetailRoute);
      expect(capturedRoute.settings.arguments, testTvSeries.id);
    });

    testWidgets('should have correct margin for the main container', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeTestableWidget(TvCard(tv: testTvSeries)));

      // Act
      final inkwellFinder = find.byType(InkWell);
      expect(inkwellFinder, findsOneWidget);
      final containerParentOfInkwell = tester.widget<Container>(
        find
            .ancestor(of: inkwellFinder, matching: find.byType(Container))
            .first,
      ); // Dapatkan Container terdekat sebagai ancestor dari InkWell

      // Assert
      expect(
        containerParentOfInkwell.margin,
        const EdgeInsets.symmetric(vertical: 4),
      );
    });

    testWidgets('should display Texts with ellipsis for overflow', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeTestableWidget(TvCard(tv: testTvSeries)));

      // Act
      final titleText = tester.widget<Text>(find.text(testTvSeries.name!));
      final overviewText = tester.widget<Text>(
        find.text(testTvSeries.overview!),
      );

      // Assert
      expect(titleText.maxLines, 1);
      expect(titleText.overflow, TextOverflow.ellipsis);
      expect(overviewText.maxLines, 2);
      expect(overviewText.overflow, TextOverflow.ellipsis);
    });
  });
}
