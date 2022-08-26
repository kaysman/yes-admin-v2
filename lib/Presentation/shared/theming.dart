// import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData? lightTheme(BuildContext context) {
    return ThemeData(
      // primarySwatch: kswPrimaryColor,
      scaffoldBackgroundColor: kWhite,
      // dataTableTheme: DataTableThemeData(
      //   checkboxHorizontalMargin: 18,
        // headingRowColor: MaterialStateProperty.resolveWith<Color>(
        //   (Set<MaterialState> states) {
        //     if (states.contains(MaterialState.selected)) {
        //       return kswPrimaryColor.withOpacity(0.3);
        //     }
        //     return kswPrimaryColor.withOpacity(0.3);
        //   },
        // ),
        // dataRowColor: MaterialStateProperty.resolveWith<Color>(
        //   (Set<MaterialState> states) {
        //     if (states.contains(MaterialState.selected)) {
        //       return kGrey5Color;
        //     }
        //     return kWhite;
        //   },
        // ),
      //   dataRowHeight: 46,
      //   headingTextStyle: GoogleFonts.poppins(
      //     fontSize: 14,
      //     fontWeight: FontWeight.w500,
      //   ),
      //   dataTextStyle: GoogleFonts.poppins(
      //       fontSize: 14, fontWeight: FontWeight.w400, color: kText1Color),
      //   dividerThickness: 0.4,
      //   headingRowHeight: 46,
      // ),
      // inputDecorationTheme: InputDecorationTheme(
      //   contentPadding: const EdgeInsets.only(left: 12, right: 8),
      //   // hintStyle: Theme.of(context)
      //   //     .textTheme
      //   //     .bodyText1!
      //   //     .copyWith(color: Colors.black54),
      //   filled: true,
      //   fillColor: kWhite,
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(2),
      //     borderSide: BorderSide(
      //       color: kGrey1Color,
      //       width: 0.0,
      //     ),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(2),
      //     borderSide: BorderSide(
      //       color: kGrey1Color,
      //       width: 0.0,
      //     ),
      //   ),
      //   errorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(2),
      //     borderSide: BorderSide(
      //       color: kPrimaryColor,
      //       width: 1.5,
      //     ),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(2),
      //     borderSide: BorderSide(
      //       color: kPrimaryColor,
      //       width: 1.5,
      //     ),
      //   ),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     onPrimary: Colors.white,
      //     padding: EdgeInsets.symmetric(
      //       vertical: 12,
      //       horizontal: 16,
      //     ),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(6),
      //     ),
      //   ),
      // ),
      // checkboxTheme: CheckboxThemeData(
      //   side: BorderSide(
      //     color: kPrimaryColor,
      //     width: 1.5,
      //   ),
      // ),
      // scrollbarTheme: ScrollbarThemeData(
      //   radius: Radius.circular(10.0),
      //   thumbColor: MaterialStateProperty.resolveWith<Color>(
      //     (states) => kGrey1Color,
      //   ),
      //   trackColor: MaterialStateProperty.resolveWith<Color>(
      //     (states) => kGrey3Color,
      //   ),
      //   thickness: MaterialStateProperty.resolveWith<double>(
      //     (states) => 4.0,
      //   ),
      // ),
      // typography: Typography()
      // textTheme: GoogleFonts.poppinsTextTheme(
      //   TextTheme(
      //     headline1: GoogleFonts.poppins(
      //       color: kText1Color,
      //       fontSize: 24,
      //       fontWeight: FontWeight.w700,
      //     ),
      //     headline2: GoogleFonts.poppins(
      //       color: kText1Color,
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //     ),
      //     headline3: GoogleFonts.poppins(
      //       color: kText1Color,
      //       fontSize: 16,
      //       fontWeight: FontWeight.w600,
      //     ),
      //     headline4: GoogleFonts.poppins(
      //       color: kText1Color,
      //       fontSize: 16,
      //       fontWeight: FontWeight.w500,
      //     ),
      //     headline5: GoogleFonts.poppins(
      //       color: kText1Color,
      //       fontSize: 16,
      //       fontWeight: FontWeight.w400,
      //     ),
      //     headline6: GoogleFonts.poppins(
      //       fontSize: 18,
      //       fontWeight: FontWeight.w700,
      //     ),
      //     bodyText1: GoogleFonts.poppins(
      //       color: kText1Color,
      //       fontSize: 14,
      //       fontWeight: FontWeight.w400,
      //     ),
      //     bodyText2: GoogleFonts.poppins(
      //       fontSize: 14,
      //       fontWeight: FontWeight.w500,
      //       color: kText1Color,
      //     ),
      //     button: GoogleFonts.poppins(
      //       fontSize: 14,
      //       fontWeight: FontWeight.w500,
      //       color: kPrimaryColor,
      //     ),
      //     subtitle1: GoogleFonts.poppins(
      //       fontSize: 16, // TextField text style uses this by default
      //       fontWeight: FontWeight.w400,
      //       color: kText1Color,
      //     ),
      //     subtitle2: GoogleFonts.poppins(
      //       fontSize: 14,
      //       fontWeight: FontWeight.w500,
      //       color: kGrey1Color,
      //     ),
      //     caption: GoogleFonts.poppins(
      //       color: kText1Color,
      //       fontSize: 12,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      // ),
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
List<BoxShadow> kBoxShadowLow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(.2, .3),
    blurRadius: 3,
  ),
];
