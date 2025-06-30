import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // inisialisasi binding sebelum test
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Theme Constants Test', () {
    test('Should use local poppins font when runtime fetching is disabled', () {
      final style = GoogleFonts.poppins();

      // Cek bahwa fontFamily-nya benar mengarah ke font lokal
      expect(style.fontFamily?.toLowerCase().contains('poppins'), isTrue);
    });

    test('BASE_IMAGE_URL should be correct', () {
      expect(baseImageUrl, 'https://image.tmdb.org/t/p/w500');
    });

    test('noImage URL should be correct', () {
      expect(
        noImage,
        'https://dummyimage.com/150x200/cccccc/000000&text=No+Image',
      );
    });

    test('kHeading5 should have correct properties', () {
      final style = kHeading5;
      expect(style.fontSize, 23);
      expect(style.fontWeight, FontWeight.w400);
      expect(
        style.fontFamily?.toLowerCase(),
        contains('poppins'),
      ); // gunakan contains
    });

    test('kHeading6 should return correct TextStyle', () {
      final style = kHeading6;
      expect(style.fontSize, 19);
      expect(style.fontWeight, FontWeight.w500);
      expect(style.letterSpacing, 0.15);
    });

    test('kSubtitle should return correct TextStyle', () {
      final style = kSubtitle;
      expect(style.fontSize, 15);
      expect(style.letterSpacing, 0.15);
    });

    test('kBodyText should return correct TextStyle', () {
      final style = kBodyText;
      expect(style.fontSize, 13);
      expect(style.letterSpacing, 0.25);
    });

    test('kTextTheme should contain correct styles', () {
      final theme = kTextTheme;
      expect(theme.headlineMedium?.fontSize, 23);
      expect(theme.headlineSmall?.fontSize, 19);
      expect(theme.labelMedium?.fontSize, 15);
      expect(theme.bodyMedium?.fontSize, 13);
    });

    test('kDrawerTheme should use grey.shade700 as background color', () {
      expect(kDrawerTheme.backgroundColor, Colors.grey.shade700);
    });

    test('kColorScheme should contain expected values', () {
      expect(kColorScheme.primary, kMikadoYellow);
      expect(kColorScheme.secondary, kPrussianBlue);
      expect(kColorScheme.surface, kRichBlack);
      expect(kColorScheme.brightness, Brightness.dark);
      expect(kColorScheme.onPrimary, kRichBlack);
    });
  });
}
