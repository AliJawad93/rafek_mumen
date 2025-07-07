import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rafek_mumen/utils/services/local_db.dart';
import 'package:rafek_mumen/utils/services/prayer_time_services.dart';

class PrayTimerController {
  final ValueNotifier<int> _nextNearestPrayTime = ValueNotifier<int>(0);
  final ValueNotifier<bool> update = ValueNotifier<bool>(false);
  late Timer _timer;
  final PrayerTimeService prayerTimeService = PrayerTimeService();
  onInitPrayerTimeService() {
    List<double> location = LocalDatabase.getCityCoordinate()!;
    prayerTimeService.onInit(location);
    _nextNearestPrayTime.value = prayerTimeService.getNextPrayTimeInSeconds();
  }

  void onInit() {
    onInitPrayerTimeService();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_nextNearestPrayTime.value > 0) {
        _nextNearestPrayTime.value--;
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          _nextNearestPrayTime.value = prayerTimeService
              .getNextPrayTimeInSeconds();
          update.value = !update.value;
        });
        // _timerActive.value = false;
      }
    });
    // _timerActive.value = true;
  }

  ValueNotifier<int> get getNextNearestPrayTimeInSeconds =>
      _nextNearestPrayTime;
  DateTime getNextNearestPrayTime() {
    return prayerTimeService.getNextNearestPrayTime();
  }
  dispose() {
    _timer.cancel();
  }
}
