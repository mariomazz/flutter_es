import 'dart:convert';

import 'package:es_2021_07_31_1/models/report_shots.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
        future: requestReportsShort(),
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

  Future<List<Report>> requestReportsShort() async {
    var url = Uri.parse("http://localhost:80/reports-short");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final List _reportsShort = json.decode(response.body);

      final reports = _reportsShort
          .map((reportJson) => Report.fromJson(reportJson))
          .toList();

      return Future.value(reports);
    }

    return [];
  }
}
