import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  static const String _nameDatabase = "islam";
  static late Box _box;
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_nameDatabase);
  }

  static clearData() {
    _box.clear();
  }

  static savePrayTimesMonth(
    Map<String, List<DateTime>> prayTimesOfMonth,
  ) async {
    _box.put("prayTimeMonth", prayTimesOfMonth);
  }

  static Map<String, List<DateTime>> getPrayTimesMonth() {
    Map<String, List<DateTime>> prayTimesOfMonth = _box.get("prayTimeMonth");
    return prayTimesOfMonth;
  }

  static void setCitiesCoordinate(Map<String, List<double>> coordinates) {
    _box.put("location", coordinates);
  }

  static List<double>? getCityCoordinate() {
    var location = _box.get("location");
    if (location == null || location.isEmpty) return null;
    return location.values.first;
  }

  static String? getSelectedCityName() {
    var location = _box.get("location");
    if (location == null || location.isEmpty) return null;
    return location.keys.first;
  }
}
