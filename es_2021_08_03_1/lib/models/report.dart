//json serializable generator

class Report {
  String? description;
  String? creationDateTimeUTC;
  String? damageType;
  Map? damageLocation;
  List? attachmentsIds;

  Report(
      {this.description,
      this.creationDateTimeUTC,
      this.damageType,
      this.damageLocation,
      this.attachmentsIds});

  factory Report.fromJson(Map<String, dynamic> json) {
    final description = json["description"] as String;
    final creationDateTimeUTC = json["creationDateTimeUTC"] as String;
    final damageType = json["damageType"] as String;
    final damageLocation = json["damageLocation"] as Map;

    // final attachmentsIds = json["attachmentsIds"] as List;

    final attachmentsIds = List<String>.from(json["attachmentsIds"]);

    return Report(
      description: description,
      creationDateTimeUTC: creationDateTimeUTC,
      damageType: damageType,
      damageLocation: damageLocation,
      attachmentsIds: attachmentsIds,
    );
  }

  Map<String, dynamic> toJson(Report report) {
    final reportJson = {
      "description": report.description,
      "creationDateTimeUTC": report.creationDateTimeUTC,
      "damageType": report.damageType,
      "damageLocation": report.damageLocation,
      "attachmentsIds": report.attachmentsIds
    };

    return reportJson;
  }
}
