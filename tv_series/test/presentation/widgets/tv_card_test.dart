import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:tv_series/module/tv_series.dart';

import '../../helpers/test_helper_tv.mocks.dart';

// Mock untuk NavigatorObserver agar bisa memverifikasi navigasi
// class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// Fake Route untuk registerFallbackValue
class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  final tMovie = TvSeries(
    adult: false,
    backdropPath: '/ottT2Yt0OfHiHp3PHJTLNVV8JPE.jpg',
    genreIds: [18, 10766],
    id: 13945,
    originCountry: ["DE"],
    originalLanguage: "de",
    originalName: "Gute Zeiten, schlechte Zeiten",
    overview:
        "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
    popularity: 677.2062,
    posterPath: "/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg",
    firstAirDate: "1992-05-11",
    name: "Gute Zeiten, schlechte Zeiten",
    voteAverage: 5.769,
    voteCount: 39,
  );

  final tMovieWithNulls = TvSeries(
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

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();
  });

  // Helper widget yang lebih robust, menyertakan Scaffold
  Widget makeMoreRobustTestableWidget(Widget body) {
    return MaterialApp(
      // Pastikan kHeading6 adalah TextStyle yang valid dan diimpor dari constants.dart
      // Jika kHeading6 menyebabkan masalah, coba hapus sementara bagian theme ini untuk diagnosis.
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: kHeading6, // kHeading6 harus berupa TextStyle
        ),
      ),
      home: Scaffold(
        // Menambahkan Scaffold di sini
        body: body,
      ),
      navigatorObservers: [mockNavigatorObserver],
      routes: {
        tvSeriesDetailRoute:
            (context) => const Scaffold(body: Text('Tv Detail Page')),
      },
    );
  }

  group('TvCard Widget Tests', () {
    testWidgets('should display TV title and overview correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeMoreRobustTestableWidget(TvCard(tv: tMovie)));

      // Act & Assert
      // Pastikan teks judul sesuai dengan tMovie.title
      expect(find.text('Gute Zeiten, schlechte Zeiten'), findsOneWidget);
      expect(find.text(tMovie.overview!), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('should display "-" when name and overview are null', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        makeMoreRobustTestableWidget(TvCard(tv: tMovieWithNulls)),
      );

      // Act & Assert
      expect(find.text('-'), findsNWidgets(2));
    });

    testWidgets(
      'should display CachedNetworkImage with correct imageUrl and show placeholder initially',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          makeMoreRobustTestableWidget(TvCard(tv: tMovie)),
        );

        // Act
        final cachedNetworkImageFinder = find.byType(CachedNetworkImage);
        expect(cachedNetworkImageFinder, findsOneWidget);
        final cachedNetworkImage = tester.widget<CachedNetworkImage>(
          cachedNetworkImageFinder,
        );

        // Assert
        expect(cachedNetworkImage.imageUrl, '$baseImageUrl{tMovie.posterPath}');

        // Placeholder harus muncul saat gambar sedang dimuat (atau sebelum gagal)
        // Mungkin perlu tester.pump() jika placeholder tidak langsung muncul
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'should display error icon when posterPath is null or image fails to load',
      (WidgetTester tester) async {
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            makeMoreRobustTestableWidget(TvCard(tv: tMovieWithNulls)),
          );

          await tester.pumpAndSettle();

          // Assert that the error icon is present and the circular progress indicator is gone.
          expect(find.byIcon(Icons.error), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsNothing);
        });
      },
    );

    testWidgets('should navigate to TvSeriesDetailPage when tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeMoreRobustTestableWidget(TvCard(tv: tMovie)));

      // Act
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Assert
      final captured =
          verify(
            () => mockNavigatorObserver.didPush(captureAny(), any()),
          ).captured;

      // Cek ada setidaknya 2 navigasi
      expect(captured.length, greaterThanOrEqualTo(2));

      final pushedRoute = captured.last as Route; // Navigasi Terakhir
      expect(pushedRoute.settings.name, tvSeriesDetailRoute);
      expect(pushedRoute.settings.arguments, tMovie.id);
    });

    testWidgets('should have correct margin for the main container', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeMoreRobustTestableWidget(TvCard(tv: tMovie)));

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
      await tester.pumpWidget(makeMoreRobustTestableWidget(TvCard(tv: tMovie)));

      // Act
      final titleText = tester.widget<Text>(find.text(tMovie.name!));
      final overviewText = tester.widget<Text>(find.text(tMovie.overview!));

      // Assert
      expect(titleText.maxLines, 1);
      expect(titleText.overflow, TextOverflow.ellipsis);
      expect(overviewText.maxLines, 2);
      expect(overviewText.overflow, TextOverflow.ellipsis);
    });
  });
}
