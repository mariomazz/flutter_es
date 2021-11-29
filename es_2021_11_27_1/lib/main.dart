import 'dart:developer';
import 'package:es_2021_11_27_1/core/api_service/api_service.dart';
import 'package:es_2021_11_27_1/ui/pages/items_page.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

void main() {
  // configuration to print calls
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    log('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
  // end - configuration to print calls
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
          create: (BuildContext context) => ApiService.create(),
          dispose: (_, ApiService service) => service.client.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: ItemsPage(),
      ),
    );
  }
}
