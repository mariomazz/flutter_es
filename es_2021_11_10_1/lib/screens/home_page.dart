import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage(
      {Key? key, required this.routeDetailPage, required this.routeErrorPage})
      : super(key: key);

  VoidCallback routeDetailPage;

  void Function(bool loggedIn) routeErrorPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => routeDetailPage.call(),
              child: Text('detail page'),
            ),
            TextButton(
              onPressed: () => routeErrorPage.call(true),
              child: Text('error page'),
            ),
          ],
        ),
      ),
    );
  }
}
