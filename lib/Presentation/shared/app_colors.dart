import 'package:flutter/material.dart';

const kPrimaryColor = Colors.blue;
const kSecondaryColor = Color(0xffEBF7F9);
final kScaffoldBgColor = Colors.grey[300];

const kText1Color = Color(0xff000000);
const kText2Color = Color(0xff333333);

const kGrey1Color = Color(0xff828282);
const kGrey2Color = Color(0xffBDBDBD);
const kGrey3Color = Color(0xffE0E0E0);
const kGrey4Color = Color(0xffF2F2F2);
const kGrey5Color = Color(0xffF7F7F7);

const kWhite = Color(0xffFFFFFF);
const kBlack = Color(0xff000000);

enum AppTheme { light, dark, darker }

extension EnvExtension on AppTheme {
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

// Primary color swatch
Map<int, Color> primarySwatch = {
  50: const Color.fromRGBO(53, 184, 190, .1),
  100: const Color.fromRGBO(53, 184, 190, .2),
  200: const Color.fromRGBO(53, 184, 190, .3),
  300: const Color.fromRGBO(53, 184, 190, .4),
  400: const Color.fromRGBO(53, 184, 190, .5),
  500: const Color.fromRGBO(53, 184, 190, .6),
  600: const Color.fromRGBO(53, 184, 190, .7),
  700: const Color.fromRGBO(53, 184, 190, .8),
  800: const Color.fromRGBO(53, 184, 190, .9),
  900: const Color.fromRGBO(53, 184, 190, 1),
};
MaterialColor kswPrimaryColor = MaterialColor(0xFF35B8BE, primarySwatch);
