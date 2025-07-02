import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:jhijri/_src/_jHijri.dart';

getHijriMothString() {
  final hijri = JHijri.now();
  return " ${hijri.day.toArabic()} ${hijri.monthName} ${hijri.year.toArabic()} هـ";
}
