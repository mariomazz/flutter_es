class Report {
  int? id;
  String? creationDateTimeUTC;
  String? status;

  Report(
      {required this.id,
      required this.creationDateTimeUTC,
      required this.status});

  factory Report.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final creationDateTimeUTC = json['creationDateTimeUTC'] as String;
    final status = json['stato'] as String;

    return Report(
        id: id, creationDateTimeUTC: creationDateTimeUTC, status: status);
  }

  Map<String, dynamic> toJson(Report report) {
    final reportJson = {
      'id': report.id,
      'createDateTimeUTC': report.creationDateTimeUTC,
      'status': report.status
    };

    return reportJson;
  }
}
