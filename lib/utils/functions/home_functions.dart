import 'package:intl/intl.dart';
import 'package:jhijri/_src/_jHijri.dart';
import 'package:rafek_mumen/core/functions/extension.dart';

getHijriDateString() {
  final hijri = JHijri.now();
  return " ${hijri.day.toArabic()} ${hijri.monthName} ${hijri.year.toArabic()} هـ";
}

getHijriMothString() {
  final hijri = JHijri.now();
  return " ${hijri.day.toArabic()} ${hijri.monthName}";
}

String getMiladiDateString() {
  final now = DateTime.now();

  // Get day and year converted to Arabic numerals using your extension
  final dayArabic = now.day.toArabic();
  final yearArabic = now.year.toArabic();

  // Get Arabic month name
  final monthName = DateFormat.MMMM('ar').format(now);

  return " $dayArabic $monthName $yearArabic م";
}

String getArabic12HourTime(DateTime? dateTime) {
  final now = dateTime ?? DateTime.now();
  final hour24 = now.hour;
  final minute = now.minute;

  // Convert to 12-hour format
  final hour12 = hour24 == 0 ? 12 : (hour24 > 12 ? hour24 - 12 : hour24);

  // Arabic AM/PM
  final period = hour24 < 12 ? 'ص' : 'م';

  // Format minute with leading zero if needed
  final minuteStr = minute.toString().padLeft(2, '0');

  return '$hour12:$minuteStr $period';
}
