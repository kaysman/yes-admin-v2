import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kswPrimaryColor,
        brightness: Brightness.light,
        background: kWhite,
        surface: kWhite,
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        onPrimary: kWhite,
        onSecondary: kBlack,
        onBackground: kBlack,
        onSurface: kBlack,
        error: AppColors.danger,
        onError: kWhite,
      ),
      scaffoldBackgroundColor: kWhite,
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kswPrimaryColor,
        brightness: Brightness.dark,
        background: AppColors.dark1,
        surface: AppColors.dark2,
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        onPrimary: kWhite,
        onSecondary: kBlack,
        onBackground: kWhite,
        onSurface: kWhite,
        error: AppColors.danger,
        onError: kWhite,
      ),
      scaffoldBackgroundColor: AppColors.dark1,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData(brightness: Brightness.dark).textTheme),
    );
  }
}

List<BoxShadow> kBoxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(0, 4),
    blurRadius: 30,
  ),
];
List<BoxShadow> kBoxHover = [
  BoxShadow(
    color: Colors.black.withOpacity(0.09),
    offset: Offset(1, 2),
    blurRadius: 10,
    spreadRadius: 12,
  ),
];
List<BoxShadow> kBoxShadowLow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(.2, .3),
    blurRadius: 3,
  ),
];
