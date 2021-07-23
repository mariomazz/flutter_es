import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, data, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Provider Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(brightness: Brightness.dark),
          ),
          home: Scaffold(
            appBar: AppBar(
              title: Text('prova'),
            ),
            body: Container(
              child: Center(
                child: Text('${data.valNum}'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int num = 0;

  int get valNum => num;

  increment() {
    num += 1;
    notifyListeners();
  }
}
