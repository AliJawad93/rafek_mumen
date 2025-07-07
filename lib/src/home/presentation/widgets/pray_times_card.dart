import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/home/presentation/controller/pray_timer_controller.dart';
import 'package:rafek_mumen/utils/functions/home_functions.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';

class PrayCard extends StatelessWidget {
  const PrayCard({super.key, required this.prayTimerController});

  final PrayTimerController prayTimerController;
  List<Color> getGradientColorsForPrayer(int prayer) {
    switch (prayer) {
      case 0: // الفجر (Fajr - Dawn)
        return [
          Color(0xFF0D1B2A),
          Color(0xFF1B263B),
          Color(0xFF415A77),
          Color(0xFF778DA9),
        ];
      case 1: // شروق (Shurooq - Sunrise)
        return [
          Color(0xFF3A86FF),
          Color(0xFF8338EC),
          Color(0xFFFF006E),
          Color(0xFFFFBE0B),
        ];
      case 2: // الظهر (Dhuhr - Noon)
        return [
          Color(0xFFFF5400),
          Color(0xFFFF6D00),
          Color(0xFFFF8500),
          Color(0xFFFF9E00),
        ];
      case 3: // الغروب (Asr - Sunset)
        return [Color(0xFFfcb045), Color(0xFFfd1d1d), Color(0xFF000814)];
      case 4: // المغرب (Maghrib - Evening/Night)
        return [
          Color(0xFF000814),
          Color(0xFF001D3D),
          Color(0xFF003566),
          Color(0xFF0A2472),
        ];
      default:
        return [Colors.grey.shade800, Colors.grey.shade600];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: getGradientColorsForPrayer(
            prayTimerController.prayerTimeService.getnextPrayIndex,
          ),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            // Current Prayer Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الصلاة القادمة',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.secondary.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      prayTimerController
                          .prayerTimeService
                          .getprayerTimeEndities[prayTimerController
                              .prayerTimeService
                              .getnextPrayIndex]
                          .title,
                      style: textTheme.headlineLarge?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      getArabic12HourTime(
                        prayTimerController.getNextNearestPrayTime(),
                      ),
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                PrayerTimeLabel(),
              ],
            ),

            // Time Until Next Prayer
            RemainingTimeDisplay(
              secondsRemaining:
                  prayTimerController.getNextNearestPrayTimeInSeconds,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  const Spacer(),
                  _prayerTimeCard(
                    title: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[0]
                        .title,
                    time: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[0]
                        .time,
                    iconData: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[0]
                        .iconData,
                    isSelect:
                        prayTimerController
                            .prayerTimeService
                            .getnextPrayIndex ==
                        0,
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                  const Spacer(),
                  _prayerTimeCard(
                    title: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[1]
                        .title,
                    time: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[1]
                        .time,
                    iconData: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[1]
                        .iconData,
                    isSelect:
                        prayTimerController
                            .prayerTimeService
                            .getnextPrayIndex ==
                        1,
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                  const Spacer(),
                  _prayerTimeCard(
                    title: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[2]
                        .title,
                    time: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[2]
                        .time,
                    iconData: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[2]
                        .iconData,
                    isSelect:
                        prayTimerController
                            .prayerTimeService
                            .getnextPrayIndex ==
                        2,
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                  const Spacer(),
                  _prayerTimeCard(
                    title: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[4]
                        .title,
                    time: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[4]
                        .time,
                    iconData: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[4]
                        .iconData,
                    isSelect:
                        prayTimerController
                            .prayerTimeService
                            .getnextPrayIndex ==
                        3,
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                  const Spacer(),
                  _prayerTimeCard(
                    title: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[5]
                        .title,
                    time: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[5]
                        .time,
                    iconData: prayTimerController
                        .prayerTimeService
                        .getprayerTimeEndities[5]
                        .iconData,
                    isSelect:
                        prayTimerController
                            .prayerTimeService
                            .getnextPrayIndex ==
                        4,
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _prayerTimeCard({
    required String title,
    required String time,
    required IconData iconData,
    required bool isSelect,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return Container(
      padding: isSelect ? 12.horizontalEdgeInsets : null,
      decoration: BoxDecoration(
        // gradient: isSelect
        //     ? LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //         colors: [
        //           // Colors.white.withOpacity(0.9),
        //           // Colors.white.withOpacity(0.7),
        //         ],
        //       )
        //     : null,
        border: isSelect
            ? Border.all(color: Colors.white.withOpacity(0.8), width: 1)
            : null,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          // if (isSelect)
          //   BoxShadow(
          //     color: Colors.white.withOpacity(0.3),
          //     blurRadius: 12,
          //     offset: const Offset(0, 4),
          //     spreadRadius: 0,
          //   ),
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.1),
          //   blurRadius: 8,
          //   offset: const Offset(0, 2),
          //   spreadRadius: 0,
          // ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(iconData, color: kSecondaryColor),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.secondary),
          ),
          Text(
            time,
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}

class PrayerTimeLabel extends StatefulWidget {
  const PrayerTimeLabel({super.key});

  @override
  State<PrayerTimeLabel> createState() => _PrayerTimeLabelState();
}

class _PrayerTimeLabelState extends State<PrayerTimeLabel> {
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();

    // Update every minute at start of next minute
    final secondsToNextMinute = 60 - _currentTime.second;
    _timer = Timer(Duration(seconds: secondsToNextMinute), () {
      _updateTime();
      // Then set periodic timer every 1 minute
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        _updateTime();
      });
    });
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        _currentTime = DateTime.now();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          getArabic12HourTime(_currentTime),
          style: textTheme.headlineMedium?.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'الوقت الحالي',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.secondary.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class RemainingTimeDisplay extends StatelessWidget {
  final ValueListenable<int> secondsRemaining;
  final TextStyle? style;

  const RemainingTimeDisplay({
    super.key,
    required this.secondsRemaining,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: secondsRemaining,
        builder: (context, secondsValue, child) {
          int hours = secondsValue ~/ 3600;
          int minutes = (secondsValue % 3600) ~/ 60;

          String arabicHours = hours.toArabic();
          String arabicMinutes = minutes.toArabic();

          String timeString = 'باقي ';
          if (hours > 0) timeString += '$arabicHours س ';
          if (minutes > 0) timeString += '$arabicMinutes د';

          if (hours == 0 && minutes == 0) {
            timeString = 'الوقت منتهي';
          }

          return Text(
            timeString.trim(),
            style:
                style ??
                textTheme.titleLarge?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
          );
        },
      ),
    );
  }
}
