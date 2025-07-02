import 'package:flutter/material.dart';
import 'package:rafek_mumen/core/functions/extension.dart';
import 'package:rafek_mumen/src/home/presentation/controller/pray_timer_controller.dart';
import 'package:rafek_mumen/utils/functions/home_functions.dart';
import 'package:rafek_mumen/utils/theme/app_colors.dart';
import 'package:rafek_mumen/utils/theme/app_theme.dart';

class DateAndTime extends StatelessWidget {
  const DateAndTime({super.key, required this.prayTimerController});

  final PrayTimerController prayTimerController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          getHijriMothString(),
          style: getTextTheme(context, 20)?.copyWith(color: kSecondaryColor),
        ),
        Text(
          "بغداد",
          style: getTextTheme(context, 18)?.copyWith(color: kSecondaryColor),
        ),
        const SizedBox(height: 40),
        ValueListenableBuilder<int>(
          valueListenable: prayTimerController.getNextNearestPrayTimeInSeconds,
          builder: (BuildContext context, int secondsValue, child) {
            int hours = secondsValue ~/ 3600;
            int minutes = (secondsValue % 3600) ~/ 60;
            int seconds = secondsValue % 60;

            return Text(
              '${seconds.toArabic().toString().padLeft(seconds < 10 ? 1 : 2, '0')} : ${minutes.toArabic().toString().padLeft(minutes < 10 ? 1 : 2, '0')} : ${hours.toArabic()}',
              style: getTextTheme(
                context,
                40,
              )?.copyWith(color: kSecondaryColor),
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: prayTimerController.update,
          builder: (BuildContext context, bool update, child) {
            return Text(
              "الوقت المتبقي لصلاة ${prayTimerController.prayerTimeService.getprayerTimeEndities[prayTimerController.prayerTimeService.getnextPrayIndex].title}",
              style: getTextTheme(
                context,
                16,
              )?.copyWith(color: kSecondaryColor),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
