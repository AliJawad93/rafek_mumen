class PrayDayWorkModel {
  final List<PrayWork> prayWork;

  PrayDayWorkModel({required this.prayWork});

  factory PrayDayWorkModel.fromJson(Map<String, dynamic> json) {
    var ayahsList = json['praies'] as List;
    List<PrayWork> prayWork = ayahsList
        .map((ayahJson) => PrayWork.fromJson(ayahJson))
        .toList();
    return PrayDayWorkModel(prayWork: prayWork);
  }
}

class PrayWork {
  final String title;
  final String description;

  final String source;

  PrayWork({
    required this.title,
    required this.description,
    required this.source,
  });
  factory PrayWork.fromJson(Map<String, dynamic> json) {
    return PrayWork(
      title: json['title'],
      description: json['description'],
      source: json['source'] ?? "",
    );
  }
}
