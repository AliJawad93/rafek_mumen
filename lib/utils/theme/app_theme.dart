import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rafek_mumen/utils/theme/sizes.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    platform: Platform.isAndroid ? TargetPlatform.android : TargetPlatform.iOS,

    useMaterial3: true,

    fontFamily: 'Tajawal',
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      primary: kPrimaryColor,
      secondary: Colors.white,
      brightness: Brightness.light,
    ),

    // dividerColor: Colors.grey,
    // scaffoldBackgroundColor: isDarkMode
    //     ? CupertinoColors.darkBackgroundGray
    //     : Colors.white,
    // secondaryHeaderColor: Colors.grey,
    // shadowColor: Colors.black,
    // splashColor: Colors.transparent,
    // unselectedWidgetColor: Colors.grey,

    // appBarTheme: const AppBarTheme(
    //   elevation: 0,
    //   backgroundColor: kPrimaryColor,
    // ),
    // cardTheme: CardThemeData(
    //   color: const Color(0xFF141415),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    // ),
    inputDecorationTheme: _inputDecorationTheme(),
  );
  static ThemeData darkTheme = ThemeData(
    platform: Platform.isAndroid ? TargetPlatform.android : TargetPlatform.iOS,

    useMaterial3: true,

    fontFamily: 'Tajawal',
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      primary: kPrimaryColor,
      secondary: Colors.white,
      brightness: Brightness.dark,
    ),

    inputDecorationTheme: _inputDecorationTheme(),
  );
  static _inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: kSecondaryColor,
      focusColor: kSecondaryColor,
      prefixIconColor: Colors.red,
      suffixIconColor: Colors.red,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),
        borderSide: const BorderSide(color: kPrimaryColor),
        // borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kRadius),

        borderSide: const BorderSide(color: Colors.grey),
        //borderRadius: BorderRadius.circular(5),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }
}

TextStyle? getTextTheme(context, int sizefont) {
  switch (sizefont) {
    case 22:
      return Theme.of(context).textTheme.displayLarge;
    case 20:
      return Theme.of(context).textTheme.displayMedium;
    case 18:
      return Theme.of(context).textTheme.displaySmall;
    case 16:
      return Theme.of(context).textTheme.bodyLarge;
    case 14:
      return Theme.of(context).textTheme.bodyMedium;
    case 12:
      return Theme.of(context).textTheme.bodySmall;
    default:
      return Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(fontSize: sizefont.toDouble());
  }
}
