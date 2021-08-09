import 'dart:convert';
import 'package:es_2021_08_3_1/models/report.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ServiceReports {
  static Future<List> readJsonFileReports() async {
    var response = await rootBundle.loadString('assets/file-json/reports.json');

    if (response.isNotEmpty) {
      final _reports = json.decode(response);
      final reports =
          _reports.map((report) => Report.fromJson(report)).toList();
      return Future.value(reports);
    }

    return [];
  }

  static Future<List> httpRequestReports() async {
    var url = Uri.parse("http://localhost:3000/reports");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final _reports = json.decode(response.body);

      final reports =
          _reports.map((report) => Report.fromJson(report)).toList();

      return Future.value(reports);
    }

    return [];
  }
}
