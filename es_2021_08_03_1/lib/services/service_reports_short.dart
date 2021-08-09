import 'dart:convert';
import 'package:es_2021_08_3_1/models/report_shots.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ServiceReportsShort {
  static Future<List<ReportShort>> readJsonFileReportsShort() async {
    var response =
        await rootBundle.loadString('assets/file-json/reports-short.json');

    if (response.isNotEmpty) {
      final List _reportsShort = json.decode(response);

      final reports = _reportsShort
          .map((reportJson) => ReportShort.fromJson(reportJson))
          .toList();

      return Future.value(reports);
    }

    return [];
  }

  static Future<List<ReportShort>> httpRequestReportsShort() async {
    var url = Uri.parse("http://localhost:80/reports-short");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> _reportsShort = json.decode(response.body);

      final List<ReportShort> reports = _reportsShort
          .map((reportJson) => ReportShort.fromJson(reportJson))
          .toList();

      return Future.value(reports);
    }

    return [];
  }
}
