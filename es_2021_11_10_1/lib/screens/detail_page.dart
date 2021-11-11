import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.routeHomePage}) : super(key: key);
  VoidCallback routeHomePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detail page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => routeHomePage.call(),
          child: Text('home page'),
        ),
      ),
    );
  }
}
