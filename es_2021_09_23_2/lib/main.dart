import 'package:flutter/material.dart';
import 'package:todolist/src/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue.shade200,
      ),
      home: MyHomePage(),
    );
  }
}
