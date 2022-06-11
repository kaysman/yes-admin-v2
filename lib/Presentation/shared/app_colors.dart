import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum AppTheme { light, dark, darker }

extension EnvExetension on AppTheme {
  // ThemeData get data => themes[this];
  Color? get headerColor => headerColors[this];
  Color? get baseColor => baseColors[this];
  Color? get bodyColor => bodyColors[this];
  Color? get subColor => subColors[this];
  String? get iconUrl => icons[this];

  // static final themes = {
  //   AppTheme.light: lightTheme,
  //   AppTheme.dark: darkTheme,
  // };

  static final headerColors = {
    AppTheme.light: Colors.white,
    AppTheme.dark: AppColors.dark,
  };

  static final bodyColors = {
    AppTheme.light: Colors.black,
    AppTheme.dark: Colors.white,
  };

  static final subColors = {
    AppTheme.light: AppColors.darkText,
    AppTheme.dark: Colors.white30
  };

  static final baseColors = {
    AppTheme.light: Colors.white,
    AppTheme.dark: AppColors.dark1
  };

  static final icons = {
    AppTheme.light: 'assets/logo/teamtime/dark.svg',
    AppTheme.dark: 'assets/logo/teamtime/light.svg',
    AppTheme.darker: 'assets/logo/teamtime/light.svg',
  };
}

// 0xff1C162E
class AppColors {
  static const Color dark = Color(0xff12161B);
  static const Color dark1 = Color(0xff0F1115);
  static const Color dark2 = Color(0xff181B22);
  static const Color darkGrey = Color(0xff30424A);
  static const Color iconGrey = Color(0xffC7CED1);
  static const Color green = Color(0xFF087E2A);
  static const Color green2 = Color(0xFF15AA40);
  static const Color lightGreen = Color(0xffE7F3EA);
  static const Color superLightGreen = Color(0xffF8FBF9);
  static const Color darkText = Color(0xff30424B);
  static const Color mediumText = Color(0xFF597380);
  static const Color mediumText2 = Color(0xff9FAAAF);
  static const Color basecampYellow = Color(0xffFED932);
  static const Color warning = Color(0xfffdc641);
  static const Color shimmerGrey = Color(0xff455A64);
  static const Color shimmerBase = Color(0xffE4E7E8);
  static const Color shimmerHighlight = Color(0xffF3F4F4);
  static const Color danger = Color(0xffdf4759);
}
