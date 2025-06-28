import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
const String noImage =
    'https://dummyimage.com/150x200/cccccc/000000&text=No+Image';

// Text Styles (pakai getter agar bisa dites)
TextStyle get kHeading5 =>
    GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);

TextStyle get kHeading6 => GoogleFonts.poppins(
  fontSize: 19,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);

TextStyle get kSubtitle => GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.15,
);

TextStyle get kBodyText => GoogleFonts.poppins(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

// TextTheme
TextTheme get kTextTheme => TextTheme(
  headlineMedium: kHeading5,
  headlineSmall: kHeading6,
  labelMedium: kSubtitle,
  bodyMedium: kBodyText,
);

// Drawer Theme
final kDrawerTheme = DrawerThemeData(backgroundColor: Colors.grey.shade700);
