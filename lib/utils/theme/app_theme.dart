import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final _platform = defaultTargetPlatform;

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      primary: kPrimaryColor,
      secondary: Colors.white,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      platform: _platform,
      fontFamily: 'Tajawal',
      primaryColor: kPrimaryColor,
      colorScheme: colorScheme,
      cardTheme: _cardTheme(colorScheme),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: kPrimaryColor,
      primary: kPrimaryColor,
      secondary: Colors.white,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      platform: _platform,
      fontFamily: 'Tajawal',
      primaryColor: kPrimaryColor,
      colorScheme: colorScheme,
      cardTheme: _cardTheme(colorScheme),
    );
  }

  static CardThemeData _cardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      elevation: 0,
      color: colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
          width: 0,
        ),
      ),
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
