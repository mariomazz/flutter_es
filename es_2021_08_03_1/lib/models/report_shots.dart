class ReportShort {
  int? id;
  String? creationDateTimeUTC;
  String? status;

  ReportShort(
      {required this.id,
      required this.creationDateTimeUTC,
      required this.status});

  factory ReportShort.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final creationDateTimeUTC = json['creationDateTimeUTC'] as String;
    final status = json['stato'] as String;

    return ReportShort(
        id: id, creationDateTimeUTC: creationDateTimeUTC, status: status);
  }

  Map<String, dynamic> toJson(ReportShort report) {
    final reportJson = {
      'id': report.id,
      'createDateTimeUTC': report.creationDateTimeUTC,
      'status': report.status
    };

    return reportJson;
  }
}
