import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';

//================================================================================
// BAGIAN 1: TES LOGIKA & UI (Menggunakan Aset Palsu)
// Tes ini berjalan cepat dan tidak bergantung pada file aset asli.
// Tujuannya untuk memvalidasi logika, teks, dan callback.
//================================================================================

/// AssetBundle palsu untuk mem-bypass pemuatan aset lottie asli saat pengujian.
/// Ini mengembalikan data JSON lottie minimal yang valid untuk setiap permintaan .json.
class FakeAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    if (key.endsWith('.json')) {
      const String dummyLottieData =
          '{"v":"5.5.0","fr":30,"ip":0,"op":60,"w":512,"h":512,"nm":"test","ddd":0,"assets":[],"layers":[]}';
      return ByteData.view(utf8.encoder.convert(dummyLottieData).buffer);
    }
    // Untuk aset lain (seperti font), teruskan ke bundle default aplikasi.
    return rootBundle.load(key);
  }
}

void main() {
  group('Unit Test: detectErrorType', () {
    test(
      'should return ErrorType.noConnection for network failure message',
      () {
        expect(
          detectErrorType("Failed to connect to the network"),
          ErrorType.noConnection,
        );
      },
    );

    test('should return ErrorType.noResult for no results message', () {
      expect(detectErrorType("No results found"), ErrorType.noResult);
    });

    test('should return ErrorType.invalidQuery for invalid query message', () {
      expect(
        detectErrorType("Query contains invalid characters"),
        ErrorType.invalidQuery,
      );
    });

    test('should return ErrorType.emptyQuery for empty query message', () {
      expect(detectErrorType("Query cannot be empty"), ErrorType.emptyQuery);
    });

    test('should return ErrorType.serverError for any other message', () {
      expect(
        detectErrorType("An unexpected error occurred"),
        ErrorType.serverError,
      );
      expect(detectErrorType("Internal Server Error"), ErrorType.serverError);
    });
  });

  group('Widget Logic Tests (with Fake Assets)', () {
    // Fungsi helper untuk mem-pump widget dengan AssetBundle palsu
    Future<void> pumpWithFakeAssets(WidgetTester tester, Widget widget) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DefaultAssetBundle(
            bundle: FakeAssetBundle(),
            child: Scaffold(body: widget),
          ),
        ),
      );
    }

    testWidgets('ErrorStateWidget should display correct text for each state', (
      WidgetTester tester,
    ) async {
      // Tes state No Connection
      await pumpWithFakeAssets(
        tester,
        const ErrorStateWidget(
          message: 'Failed to connect to the network',
          title: 'Movie',
        ),
      );
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.text('No Internet Connection!'), findsOneWidget);

      // Tes state No Result
      await pumpWithFakeAssets(
        tester,
        const ErrorStateWidget(message: 'No results found', title: 'Movie'),
      );
      expect(find.text('Movie Search Not Found!'), findsOneWidget);
    });

    testWidgets(
      'ErrorStateWidget2 should display message and handle retry tap',
      (WidgetTester tester) async {
        bool retryTapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorStateWidget2(
                message: 'Failed to load data.',
                onRetry: () => retryTapped = true,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.error_outline), findsOneWidget);
        expect(find.text('Failed to load data.'), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);

        await tester.tap(
          find.byKey(const Key('elevated_button_ErrorStateWidget2')),
        );
        expect(retryTapped, isTrue);
      },
    );

    testWidgets('EmptyStateWidget should display correct message', (
      WidgetTester tester,
    ) async {
      await pumpWithFakeAssets(
        tester,
        const EmptyStateWidget(message: 'Your watchlist is empty.'),
      );
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.text('Your watchlist is empty.'), findsOneWidget);
    });
  });

  // TES WIDGET DENGAN ASET ASLI
  group('Widget Integration Tests (with Real Assets)', () {
    Widget buildTestableWidget(Widget child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: child)),
      );
    }

    testWidgets('ErrorStateWidget should display correct text for each state', (
      WidgetTester tester,
    ) async {
      /// Tes state No Connection
      final widget1 = buildTestableWidget(
        ErrorStateWidget(
          message: 'Failed to connect to the network',
          title: 'Movie',
        ),
      );

      await tester.pumpWidget(widget1);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Lottie), findsOneWidget);
      expect(find.text('No Internet Connection!'), findsOneWidget);

      /// Tes state No Result
      final widget2 = buildTestableWidget(
        const ErrorStateWidget(message: 'No results found', title: 'Movie'),
      );
      await tester.pumpWidget(widget2);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Movie Search Not Found!'), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets(
      'ErrorStateWidget2 should display message and handle retry tap',
      (WidgetTester tester) async {
        bool retryTapped = false;

        // Tes ini tidak terpengaruh karena tidak memuat aset Lottie.
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ErrorStateWidget2(
                message: 'Failed to load data.',
                onRetry: () => retryTapped = true,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.error_outline), findsOneWidget);
        expect(find.text('Failed to load data.'), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);

        await tester.tap(
          find.byKey(const Key('elevated_button_ErrorStateWidget2')),
        );
        expect(retryTapped, isTrue);
      },
    );

    testWidgets('EmptyStateWidget should display correct message', (
      WidgetTester tester,
    ) async {
      // EmptyStateWidget memuat aset lottie tertentu.
      final widget = buildTestableWidget(
        const EmptyStateWidget(message: 'Your watchlist is empty.'),
      );

      await tester.pumpWidget(widget);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(Lottie), findsOneWidget);
      expect(find.text('Your watchlist is empty.'), findsOneWidget);
    });
  });
}
