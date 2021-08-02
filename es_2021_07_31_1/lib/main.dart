import 'dart:convert';

import 'package:es_2021_07_31_1/models/report_shots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('prova'),
      ),
      body: FutureBuilder<List<Report>>(
        future: readJsonFileReportsShort(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Report> reports = snapshot.data ?? [];

            return ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.access_alarms),
                      title: Text(reports[index].id.toString()),
                      subtitle:
                          Text(reports[index].creationDateTimeUTC.toString()),
                    ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Report>> httpRequestReportsShort() async {
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

  Future<List<Report>> readJsonFileReportsShort() async {
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
}
