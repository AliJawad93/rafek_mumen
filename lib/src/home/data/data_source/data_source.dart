import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:rafek_mumen/core/const/paths.dart';
import 'package:rafek_mumen/core/genarics/data_state.dart';

import '../models/pray_day_work_model.dart';

class HomeDataSource {
  static Future<DataState<PrayDayWorkModel>> getPrayDayWork(
    String dayFileName,
  ) async {
    try {
      String jsonString = await rootBundle.loadString(
        kPrayDayWork + dayFileName,
      );
      Map<String, dynamic> response = jsonDecode(jsonString);
      return DataSuccess(PrayDayWorkModel.fromJson(response));
    } catch (e) {
      log("getQuranSurahs : $e");

      return DataFailed(ApiError(code: 3, msg: e.toString()));
    }
  }
}
