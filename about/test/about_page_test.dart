import 'package:about/module/about.dart';
import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'about_page_test.mocks.dart';

@GenerateMocks([CustomDrawerNotifier, AnimationController])
void main() {
  // Deklarasikan variabel mock di luar testWidgets agar bisa diakses
  late MockCustomDrawerNotifier mockNotifier;

  setUp(() {
    // Inisialisasi mock baru untuk setiap tes
    mockNotifier = MockCustomDrawerNotifier();
  });

  /// Kelompokkan tes yang berhubungan dengan AboutPage
  group('AboutPage', () {
    /// Memastikan semua widget utama muncul saat halaman dirender.
    testWidgets('Should display all major widgets correctly', (
      WidgetTester tester,
    ) async {
      // Arrange: Render AboutPage di dalam MaterialApp untuk menyediakan konteks dasar.
      await tester.pumpWidget(const MaterialApp(home: AboutPage()));

      // Assert: Verifikasi keberadaan widget-widget kunci.
      // 1. Cari AppBar berdasarkan judulnya.
      expect(find.text('About App'), findsOneWidget);

      // 2. Cari tombol menu berdasarkan ikonnya.
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // 3. Cari gambar berdasarkan tipenya. Ini cara sederhana untuk memastikan ada widget Image.
      expect(find.byType(Image), findsOneWidget);

      // 4. Cari teks deskripsi yang panjang.
      // Kita bisa mencari sebagian teksnya saja agar tidak terlalu rapuh.
      expect(
        find.textContaining(
          'Ditonton merupakan sebuah aplikasi katalog film',
          findRichText: true,
        ),
        findsOneWidget,
      );
    });

    /// Memverifikasi properti spesifik dari widget Text.
    testWidgets(
      'The description text must have the correct style and alignment.',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(const MaterialApp(home: AboutPage()));

        // Act: Temukan widget RichText yang ingin diuji.
        // Ganti <Text> menjadi <RichText>
        final descriptionRichText = tester.widget<RichText>(
          find.textContaining('Ditonton merupakan', findRichText: true),
        );

        // Assert: Periksa properti dari widget RichText tersebut.
        // 1. Verifikasi textAlign langsung pada RichText
        expect(descriptionRichText.textAlign, TextAlign.justify);

        // 2. Untuk style, kita perlu mengakses TextSpan di dalamnya.
        // Lakukan cast pada properti 'text' menjadi 'TextSpan' untuk mengakses 'style'.
        final textSpan = descriptionRichText.text as TextSpan;
        expect(textSpan.style?.fontSize, 16);
        expect(textSpan.style?.color, Colors.black87);
      },
    );

    /// Menguji interaksi menekan tombol menu.
    testWidgets(
      'Pressing the menu button should bring up the toggle on the CustomDrawerNotifier.',
      (WidgetTester tester) async {
        // Arrange:
        // Stubbing: Beritahu mockito apa yang harus dilakukan ketika metode dipanggil.
        // metode toggle() tidak melakukan apa-apa (return void).
        when(mockNotifier.toggle()).thenAnswer((_) async {});

        // Render AboutPage, dibungkus dengan Provider yang kita butuhkan.
        await tester.pumpWidget(
          ChangeNotifierProvider<CustomDrawerNotifier>.value(
            value: mockNotifier, // Sediakan instance mock kita
            child: MaterialApp(home: AboutPage()),
          ),
        );

        // Act: Simulasi menekan tombol menu.
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pump(); // pump() untuk memproses frame setelah tap

        // Assert: Verifikasi bahwa metode toggle() pada notifier kita dipanggil tepat 1 kali.
        verify(mockNotifier.toggle()).called(1);
      },
    );
  });
}
