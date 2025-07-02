import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:rafek_mumen/core/const/paths.dart';
import 'package:rafek_mumen/core/genarics/data_state.dart';

import '../models/quran_model.dart';

class QuranDataSource {
  static Future<DataState<QuranModel>> getQuranSurahs() async {
    try {
      String jsonString = await rootBundle.loadString(kQuranSurah);
      Map<String, dynamic> response = jsonDecode(jsonString);
      //  final response = await compute(loadQuranSurahs, kQuranSurah);
      return DataSuccess(QuranModel.fromJson(response));
    } catch (e) {
      log("getQuranSurahs : $e");

      return DataFailed(ApiError(code: 3, msg: e.toString()));
    }
  }
}

Future<Map<String, dynamic>> loadQuranSurahs(void _) async {
  String jsonString = await rootBundle.loadString(kQuranSurah);
  Map<String, dynamic> response = jsonDecode(jsonString);
  return response;
}
