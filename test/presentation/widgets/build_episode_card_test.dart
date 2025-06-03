import 'package:ditonton_clean_architecture/common/constants.dart';
import 'package:ditonton_clean_architecture/common/utils.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/build_episode_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  const testTitle = 'Episode 1';
  const testName = 'Pilot';
  const testAirDate = '2023-01-01';
  const testOverview = 'This is the first episode of the series';
  const testImagePath = '/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg';
  const testRuntime = 45;

  Widget buildTestWidget({
    String title = testTitle,
    String? name = testName,
    String? airDate = testAirDate,
    String? overview = testOverview,
    String? imagePath = testImagePath,
    int? runtime = testRuntime,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder:
              (context) => buildEpisodeCard(
                context,
                title: title,
                name: name,
                airDate: airDate,
                overview: overview,
                imagePath: imagePath,
                runtime: runtime,
              ),
        ),
      ),
    );
  }

  group('buildEpisodeCard Widget', () {
    testWidgets('should render all provided data correctly', (
      WidgetTester tester,
    ) async {
      await mockNetworkImages(() async {
        await tester.pumpWidget(buildTestWidget());

        // Verify title is displayed
        expect(find.text(testTitle), findsOneWidget);

        // Verify episode name is displayed
        expect(find.text('$testTitle: $testName'), findsOneWidget);

        // Verify air date is displayed
        expect(find.text('Air Date: $testAirDate'), findsOneWidget);

        // Verify overview is displayed
        expect(find.text(testOverview), findsOneWidget);

        // Verify runtime is displayed with formatted duration
        expect(
          find.text('Duration: ${showDuration(testRuntime)}'),
          findsOneWidget,
        );

        // Verify image is loaded with correct path
        final image = tester.widget<Image>(find.byType(Image));
        expect(
          (image.image as NetworkImage).url,
          'https://image.tmdb.org/t/p/w500$testImagePath',
        );
      });
    });

    testWidgets('should handle null name correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(name: null));

      expect(find.text('$testTitle: Name Is Not Available'), findsOneWidget);
    });

    testWidgets('should handle null airDate correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(airDate: null));

      expect(find.text('Air Date: Air Date Is Not Available'), findsOneWidget);
      expect(find.text(formatAirDate(null)), findsOneWidget);
    });

    testWidgets('should handle empty overview correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(overview: ''));

      expect(find.text('Description Is Not Available'), findsOneWidget);
    });

    testWidgets('should handle null runtime correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(runtime: null));

      expect(find.text('Duration: Duration Is Not Available'), findsOneWidget);
    });

    testWidgets('should handle null imagePath correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(imagePath: null));

      final image = tester.widget<Image>(find.byType(Image));
      expect((image.image as NetworkImage).url, noImage);
    });

    testWidgets('should have correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Verify card color
      final card = tester.widget<Card>(find.byType(Card));
      expect(card.color, Colors.blueAccent);

      // Verify image border radius
      final clipRRect = tester.widget<ClipRRect>(
        find.descendant(
          of: find.byType(Card),
          matching: find.byType(ClipRRect),
        ),
      );
      expect(
        clipRRect.borderRadius,
        const BorderRadius.vertical(top: Radius.circular(12)),
      );

      // Verify image dimensions
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.width, double.infinity);
      expect(image.height, 200);
      expect(image.fit, BoxFit.cover);
    });

    testWidgets('should have proper layout structure', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Sesuai dengan struktur, ada 3 Column widget di buildEpisodeCard
      expect(find.byType(Column), findsNWidgets(3));

      // Memastikan Card ada
      expect(find.byType(Card), findsOneWidget);

      // Memastikan Image widget ada
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
