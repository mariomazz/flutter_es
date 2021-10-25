 import 'package:es_2021_10_11_1/home.dart';
 import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      title: 'my app',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
 
