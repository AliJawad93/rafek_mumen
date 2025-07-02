import 'package:flutter/material.dart';

extension NumberConverter on int {
  String toArabic() {
    // Define mapping for English to Arabic numerals
    Map<String, String> numeralsMap = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };
    // Convert each digit to Arabic numeral
    String arabicNumber = toString().split('').map((digit) {
      return numeralsMap[digit] ?? digit;
    }).join('');

    return arabicNumber;
  }
}

extension NumExt on num {
  EdgeInsets get allEdgeInsets {
    return EdgeInsets.all(toDouble());
  }

  EdgeInsets get leftEdgeInsets {
    return EdgeInsets.only(left: toDouble());
  }

  EdgeInsets get rightEdgeInsets {
    return EdgeInsets.only(right: toDouble());
  }

  EdgeInsets get topEdgeInsets {
    return EdgeInsets.only(top: toDouble());
  }

  EdgeInsets get bottomEdgeInsets {
    return EdgeInsets.only(bottom: toDouble());
  }

  EdgeInsets get horizontalEdgeInsets {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }

  EdgeInsets get verticalEdgeInsets {
    return EdgeInsets.symmetric(vertical: toDouble());
  }
}

extension NumTupleExt on (num, num) {
  EdgeInsets get symmetricEdgeInsets {
    return EdgeInsets.symmetric(
        horizontal: $1.toDouble(), vertical: $2.toDouble());
  }
}

extension StringValidation on String {
  bool isEnglishWithoutNumbersAndSymbols() {
    // Define a regular expression pattern to match Arabic characters
    RegExp regExp = RegExp(r'[a-zA-Z]');
    // Check if the given text matches the pattern
    if (!regExp.hasMatch(this)) {
      return false;
    }
    // Check if the string contains numbers or symbols
    if (RegExp(r'[0-9@#$%^&+=]').hasMatch(this)) {
      return false;
    }
    return true;
  }
}
