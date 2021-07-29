import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sizer/sizer.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyApp(),
      );
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        print(constraints.maxWidth);
        if (constraints.maxWidth < 600) {
          return Container(
            color: Colors.blueAccent,
            child: Text(
              'cellulare',
            ),
          );
        } else if (constraints.maxWidth >= 600 &&
            constraints.maxWidth <= 1000) {
          return Container(
            color: Colors.amberAccent,
            child: Text(''),
          );
        } else if (constraints.maxWidth > 1000) {
          return Container(
            color: Colors.blueGrey,
          );
        } else {
          return Container(
            color: Colors.black,
          );
        }
      }),
    );
  }
}
