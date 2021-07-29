import 'package:es_2021_07_28_1/widgets/my_custom_section.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  MediaQueryData? dataLayout;

  @override
  Widget build(BuildContext context) {
    dataLayout = MediaQuery.of(context);
    return ChangeNotifierProvider<Counter>(
      create: (context) => Counter(),
      child: Consumer<Counter>(
        builder: (context, data, widget) => Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'la mia app bar',
                style: TextStyle(
                  fontSize: ((30 * dataLayout!.size.width) / 426 < 55)
                      ? (30 * dataLayout!.size.width) / 426
                      : 55,
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) => MyCustomSection(),
            itemCount: 57,
          ),
        ),
      ),
    );
  }
}

// Counter provider

class Counter with ChangeNotifier {
  int num = 21;

  int get counterNum => num;

  void increment() {
    num += 1;
    notifyListeners();
  }
}
