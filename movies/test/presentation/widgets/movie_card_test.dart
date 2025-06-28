import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movies/module/movies.dart';

// Mock untuk NavigatorObserver agar bisa memverifikasi navigasi
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// Fake Route untuk registerFallbackValue
class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  // Definisikan Movie dummy untuk testing
  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieWithNulls = Movie(
    adult: false,
    backdropPath: null,
    genreIds: const [],
    id: 1,
    originalTitle: null,
    // Overview null untuk tes fallback '-'
    overview: null,
    popularity: 0,
    // Poster path null untuk tes error widget
    posterPath: null,
    releaseDate: null,
    // Title null untuk tes fallback '-'
    title: null,
    video: false,
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
        movieDetailRoute:
            (context) => const Scaffold(body: Text('Movie Detail Page')),
      },
    );
  }

  group('MovieCard Widget Tests', () {
    testWidgets('should display movie title and overview correctly', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeMoreRobustTestableWidget(MovieCard(tMovie)));

      // Act & Assert
      // Pastikan teks judul sesuai dengan tMovie.title
      expect(find.text('Spider-Man'), findsOneWidget);
      expect(find.text(tMovie.overview!), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('should display "-" when title and overview are null', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        makeMoreRobustTestableWidget(MovieCard(tMovieWithNulls)),
      );

      // Act & Assert
      expect(find.text('-'), findsNWidgets(2));
    });

    testWidgets(
      'should display CachedNetworkImage with correct imageUrl and show placeholder initially',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          makeMoreRobustTestableWidget(MovieCard(tMovie)),
        );

        // Act
        final cachedNetworkImageFinder = find.byType(CachedNetworkImage);
        expect(cachedNetworkImageFinder, findsOneWidget);
        final cachedNetworkImage = tester.widget<CachedNetworkImage>(
          cachedNetworkImageFinder,
        );

        // Assert
        expect(
          cachedNetworkImage.imageUrl,
          '$baseImageUrl${tMovie.posterPath}',
        );

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
            makeMoreRobustTestableWidget(MovieCard(tMovieWithNulls)),
          );

          await tester.pumpAndSettle(); // Increased duration slightly

          // Assert that the error icon is present and the circular progress indicator is gone.
          expect(find.byIcon(Icons.error), findsOneWidget);
          expect(find.byType(CircularProgressIndicator), findsNothing);
        });
      },
    );

    testWidgets('should navigate to MovieDetailPage when tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeMoreRobustTestableWidget(MovieCard(tMovie)));

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
      expect(pushedRoute.settings.name, movieDetailRoute);
      expect(pushedRoute.settings.arguments, tMovie.id);
    });

    testWidgets('should have correct margin for the main container', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(makeMoreRobustTestableWidget(MovieCard(tMovie)));

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
      await tester.pumpWidget(makeMoreRobustTestableWidget(MovieCard(tMovie)));

      // Act
      final titleText = tester.widget<Text>(find.text(tMovie.title!));
      final overviewText = tester.widget<Text>(find.text(tMovie.overview!));

      // Assert
      expect(titleText.maxLines, 1);
      expect(titleText.overflow, TextOverflow.ellipsis);
      expect(overviewText.maxLines, 2);
      expect(overviewText.overflow, TextOverflow.ellipsis);
    });
  });
}
