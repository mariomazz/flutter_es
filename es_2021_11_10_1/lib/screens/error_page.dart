import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ErrorPage extends StatelessWidget {
  ErrorPage({Key? key, required this.returnHomePage}) : super(key: key);

  VoidCallback returnHomePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('error page'),
      ),
      body: Center(
        child: Text('error page'),
      ),
    );
  }
}
