import 'dart:convert';
import 'package:es_2021_07_31_1/models/report_shots.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<Report>> readJsonFileReportsShort() async {
    var response =
        await rootBundle.loadString('assets/file-json/reports-short.json');

    if (response.isNotEmpty) {
      final List _reportsShort = json.decode(response);

      final reports = _reportsShort
          .map((reportJson) => Report.fromJson(reportJson))
          .toList();

      return Future.value(reports);
    }

    return [];
  }

  static Future<List<Report>> httpRequestReportsShort() async {
    // crezione url per la richiesta http

    var url = Uri.parse("http://localhost:80/reports-short");

    // richiesta get con il metodo http , risultato => 'Stringa' , lo immetto nella variabile response

    var response = await http.get(url);

    // se la richiesta al server è andata a buon fine entra ad eseguire il codice nella if, se il server non ha risposto per qualche motivo viene restituito un'array vuoto

    if (response.statusCode == 200) {
      // json.decode => fa la decodifica della stringa ricevuta in precedenza dal server => ora abbiamo una lista creata da un file json

      final List<dynamic> _reportsShort = json.decode(response.body);

      // scorro tutti gli elementi della lista creata dal file json, iniettandola nella mia lista di Reports

      final List<Report> reports = _reportsShort
          .map((reportJson) => Report.fromJson(reportJson))
          .toList();

      // alla fine quando è tutto mappato la ritorno al mio future builder per la visualizzazione della lista

      return Future.value(reports);
    }

    return [];
  }
}
