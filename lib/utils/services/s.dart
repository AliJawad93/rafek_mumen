// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:rafek_mumen/core/services/prayer_time.dart';
// import 'package:rafek_mumen/utils/services/local_db.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class PrayerTimeService {
//   final List<String> _prayerNames = [
//     "الفجر",
//     "شروق ",
//     "الظهر",
//     "الغروب",
//     "المغرب",
//   ];
//   final List<IconData> _prayerIcons = [
//     LucideIcons.cloudSun,
//     LucideIcons.sunrise,
//     LucideIcons.sun,
//     LucideIcons.sunset,
//     LucideIcons.cloudMoon,
//   ];
//   List<DateTime> _prayerTimes = [];
//   final List<PrayerTimeEndity> _prayerTimeEndities = [];
//   PrayerTime prayerTime = PrayerTime();
//   int selectedPray = 0;

//   onInit() {
//     DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//     DateTime dateTime = DateTime.now();
//     Map<String, List<String>> prayTimesOfMonth =
//         calculationPrayTimesOfMonth(dateTime, dateFormat);
//     _storePrayTimesOfMonthToDatabase(prayTimesOfMonth);
//     // getNextPrayTimeInSeconds(dateTime, dateFormat);
//   }

//   int getNextPrayTimeInSeconds() {
//     DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//     DateTime dateTime = DateTime.now();
//     Map<String, List<String>> prayTimesOfMonth =
//         LocalDatabase.getPrayTimesMonth();

//     List<DateTime> futureTimes =
//         _getFuturePrayTimes(dateTime, dateFormat, prayTimesOfMonth);
//     _setPrayerTimeEndity();
//     log("LocalDatabase futureTimes :$futureTimes");

//     DateTime nextNearestTime =
//         futureTimes.reduce((a, b) => a.isBefore(b) ? a : b);
//     log("LocalDatabase nextNearestTime :$nextNearestTime");
//     log("LocalDatabase futureTimes :$_prayerTimes");

//     int index = [_prayerTimes[0], _prayerTimes[2], _prayerTimes[5]]
//         .indexOf(nextNearestTime);
//     selectedPray = index == 0
//         ? 0
//         : index == 1
//             ? 2
//             : 4;

//     return nextNearestTime.difference(dateTime).inSeconds;
//   }

//   List<DateTime> _getFuturePrayTimes(DateTime dateTime, DateFormat dateFormat,
//       Map<String, List<String>> prayTimesOfMonth) {
//     List<DateTime> futureTimes =
//         _getFutureTimes(false, dateTime, dateFormat, prayTimesOfMonth);

//     if (futureTimes.isEmpty) {
//       log("LocalDatabase  isEmpty: ${futureTimes.isEmpty}");
//       DateTime newDateTime = dateTime.add(const Duration(days: 1));
//       futureTimes =
//           _getFutureTimes(true, newDateTime, dateFormat, prayTimesOfMonth);
//     }

//     return futureTimes;
//   }

//   void _setPrayerTimeEndity() {
//     for (var i = 0; i < 5; i++) {
//       // Format the DateTime object using the Arabic locale
//       String formattedTime =
//           DateFormat('h:mm a', 'ar_SA').format(_prayerTimes[i]);

//       _prayerTimeEndities.add(PrayerTimeEndity(
//           title: _prayerNames[i],
//           time: formattedTime,
//           iconData: _prayerIcons[i]));
//     }
//   }

//   _storePrayTimesOfMonthToDatabase(Map<String, List<String>> prayTimesOfMonth) {
//     LocalDatabase.savePrayTimesMonth(prayTimesOfMonth);
//   }

//   Map<String, List<String>> calculationPrayTimesOfMonth(
//       DateTime dateTime, DateFormat dateFormat) {
//     Map<String, List<String>> prayTimesOfMonth = {};

//     for (var i = 0; i < 30; i++) {
//       final DateTime tomorrowDate = dateTime.add(Duration(days: i));
//       List<String> prayerTimes =
//           prayerTime.getPrayerTimes(tomorrowDate, 33.287050, 44.330586);
//       prayTimesOfMonth[dateFormat.format(tomorrowDate)] = prayerTimes;
//     }

//     return prayTimesOfMonth;
//   }

//   DateTime _parseTime(String time) {
//     final dateTime = DateFormat('h:mm a').parse(time);
//     return DateTime(0, 1, 1, dateTime.hour, dateTime.minute);
//   }

//   List<DateTime> _getFutureTimes(bool isSecondTime, DateTime dateTime,
//       DateFormat dateFormat, Map<String, List<String>> prayTimesOfMonth) {
       

  

//     _prayerTimes = _getPrayTimeDayInDateTime(dateTime, dateFormat, prayTimesOfMonth);
//     List<DateTime> times = [_prayerTimes[0], _prayerTimes[2], _prayerTimes[5]];
//     if (isSecondTime) {
//       dateTime = dateTime.subtract(const Duration(days: 1));
//     }
//     List<DateTime> futureTimes =
//         times.where((time) => time.isAfter(dateTime)).toList();
//     log("LocalDatabase  $dateTime: $times , $futureTimes");
//     return futureTimes;
//   }

//   List<DateTime> _getPrayTimeDayInDateTime(DateTime dateTime,
//       DateFormat dateFormat, Map<String, List<String>> prayTimesOfMonth) {
//     List<String> prayerTimesForDay =
//         prayTimesOfMonth[dateFormat.format(dateTime)]!;

//     List<DateTime> dateTimeList = prayerTimesForDay.map((time) {
//       DateTime parsedTime = _parseTime(time);
//       return DateTime(dateTime.year, dateTime.month, dateTime.day,
//           parsedTime.hour, parsedTime.minute);
//     }).toList();
//     return dateTimeList;
//   }

//   int get getnextPrayIndex => selectedPray;
//   List<PrayerTimeEndity> get getprayerTimeEndities => _prayerTimeEndities;
// }

// class PrayerTimeEndity {
//   final String title;
//   final String time;
//   final IconData iconData;

//   PrayerTimeEndity(
//       {required this.title, required this.time, required this.iconData});
// }

// /*
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:rafek_mumen/core/services/prayer_time.dart';
// import 'package:rafek_mumen/utils/services/local_db.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class PrayerTimeService {
//   final List<String> _prayerNames = [
//     "الفجر",
//     "شروق ",
//     "الظهر",
//     "الغروب",
//     "المغرب",
//   ];
//   final List<IconData> _prayerIcons = [
//     LucideIcons.cloudSun,
//     LucideIcons.sunrise,
//     LucideIcons.sun,
//     LucideIcons.sunset,
//     LucideIcons.cloudMoon,
//   ];
//   List<DateTime> _prayerTimes = [];
//   final List<PrayerTimeEndity> _prayerTimeEndities = [];
//   PrayerTime prayerTime = PrayerTime();
//   int selectedPray = 0;

//   onInit() {
//     DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//     DateTime dateTime = DateTime.now();
//     Map<String, List<String>> prayTimesOfMonth =
//         calculationPrayTimesOfMonth(dateTime, dateFormat);
//     _storePrayTimesOfMonthToDatabase(prayTimesOfMonth);
//     // getNextPrayTimeInSeconds(dateTime, dateFormat);
//   }

//   int getNextPrayTimeInSeconds() {
//     DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//     DateTime dateTime = DateTime.now();
//     Map<String, List<String>> prayTimesOfMonth =
//         LocalDatabase.getPrayTimesMonth();
//     List<DateTime> futureTimes =
//         _getFuturePrayTimes(dateTime, dateFormat, prayTimesOfMonth);
//     _setPrayerTimeEndity();
//     log("LocalDatabase futureTimes :$futureTimes");

//     DateTime nextNearestTime =
//         futureTimes.reduce((a, b) => a.isBefore(b) ? a : b);
//     log("LocalDatabase nextNearestTime :$nextNearestTime");
//     log("LocalDatabase futureTimes :$_prayerTimes");

//     int index = [_prayerTimes[0], _prayerTimes[2], _prayerTimes[5]]
//         .indexOf(nextNearestTime);
//     selectedPray = index == 0
//         ? 0
//         : index == 1
//             ? 2
//             : 4;

//     return nextNearestTime.difference(dateTime).inSeconds;
//   }

//   List<DateTime> _getFuturePrayTimes(DateTime dateTime, DateFormat dateFormat,
//       Map<String, List<String>> prayTimesOfMonth) {
//     List<DateTime> futureTimes =
//         _getFutureTimes(false, dateTime, dateFormat, prayTimesOfMonth);

//     if (futureTimes.isEmpty) {
//       log("LocalDatabase  isEmpty: ${futureTimes.isEmpty}");
//       DateTime newDateTime = dateTime.add(const Duration(days: 1));
//       futureTimes =
//           _getFutureTimes(true, newDateTime, dateFormat, prayTimesOfMonth);
//     }

//     return futureTimes;
//   }

//   void _setPrayerTimeEndity() {
//     for (var i = 0; i < 5; i++) {
//       // Format the DateTime object using the Arabic locale
//       String formattedTime =
//           DateFormat('h:mm a', 'ar_SA').format(_prayerTimes[i]);

//       _prayerTimeEndities.add(PrayerTimeEndity(
//           title: _prayerNames[i],
//           time: formattedTime,
//           iconData: _prayerIcons[i]));
//     }
//   }

//   _storePrayTimesOfMonthToDatabase(Map<String, List<String>> prayTimesOfMonth) {
//     LocalDatabase.savePrayTimesMonth(prayTimesOfMonth);
//   }

//   Map<String, List<String>> calculationPrayTimesOfMonth(
//       DateTime dateTime, DateFormat dateFormat) {
//     Map<String, List<String>> prayTimesOfMonth = {};

//     for (var i = 0; i < 30; i++) {
//       final DateTime tomorrowDate = dateTime.add(Duration(days: i));
//       List<String> prayerTimes =
//           prayerTime.getPrayerTimes(tomorrowDate, 33.287050, 44.330586);
//       prayTimesOfMonth[dateFormat.format(tomorrowDate)] = prayerTimes;
//     }

//     return prayTimesOfMonth;
//   }

//   DateTime _parseTime(String time) {
//     final dateTime = DateFormat('h:mm a').parse(time);
//     return DateTime(0, 1, 1, dateTime.hour, dateTime.minute);
//   }

//   List<DateTime> _getFutureTimes(bool isSecondTime, DateTime dateTime,
//       DateFormat dateFormat, Map<String, List<String>> prayTimesOfMonth) {
//     _prayerTimes =
//         _getPrayTimeDayInDateTime(dateTime, dateFormat, prayTimesOfMonth);
//     List<DateTime> times = [_prayerTimes[0], _prayerTimes[2], _prayerTimes[5]];
//     if (isSecondTime) {
//       dateTime = dateTime.subtract(const Duration(days: 1));
//     }
//     List<DateTime> futureTimes =
//         times.where((time) => time.isAfter(dateTime)).toList();
//     log("LocalDatabase  $dateTime: $times , $futureTimes");
//     return futureTimes;
//   }

//   List<DateTime> _getPrayTimeDayInDateTime(DateTime dateTime,
//       DateFormat dateFormat, Map<String, List<String>> prayTimesOfMonth) {
//     List<String> prayerTimesForDay =
//         prayTimesOfMonth[dateFormat.format(dateTime)]!;

//     List<DateTime> dateTimeList = prayerTimesForDay.map((time) {
//       DateTime parsedTime = _parseTime(time);
//       return DateTime(dateTime.year, dateTime.month, dateTime.day,
//           parsedTime.hour, parsedTime.minute);
//     }).toList();
//     return dateTimeList;
//   }

//   int get getnextPrayIndex => selectedPray;
//   List<PrayerTimeEndity> get getprayerTimeEndities => _prayerTimeEndities;
// }

// class PrayerTimeEndity {
//   final String title;
//   final String time;
//   final IconData iconData;

//   PrayerTimeEndity(
//       {required this.title, required this.time, required this.iconData});
// }




//  */