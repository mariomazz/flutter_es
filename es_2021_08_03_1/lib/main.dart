//import 'package:es_2021_08_3_1/models/report.dart';
//import 'package:es_2021_08_3_1/models/report_shots.dart';
import 'package:es_2021_08_3_1/services/services.dart';
import 'package:flutter/material.dart';

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
      body: FutureBuilder<List>(
        future: ServicesReports.httpRequestReports(),
        builder: (context, snapshot) {
          List<dynamic> mySnapshot = snapshot.data ?? [];

          if (snapshot.connectionState == ConnectionState.done) {
            final List reports = mySnapshot;
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.access_alarms),
                  title: Text(reports[index].description.toString()),
                  subtitle: Text(reports[index].creationDateTimeUTC.toString()),
                );
              },
              itemCount: reports.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
