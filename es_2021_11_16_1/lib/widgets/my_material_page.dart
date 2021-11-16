import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyMaterialPage extends Page {
  MyMaterialPage({this.key, required this.child}) : super(key: key);
  LocalKey? key;
  Widget child;
  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return child;
      },
    );
  }
}
