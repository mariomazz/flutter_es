import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => SecondPage(),
          ),
        ),
        child: Hero(
          tag: "DemoTag",
          child: Icon(
            Icons.add,
            size: 70.0,
          ),
          placeholderBuilder: (context, widget, _) {
            return Container(
              height: 70.0,
              width: 70.0,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
        elevation: 0,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Hero(
            tag: "DemoTag",
            child: Icon(
              Icons.add,
              size: 150.0,
            ),
            placeholderBuilder: (context, widget, _) {
              return Container(
                height: 150.0,
                width: 150.0,
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
