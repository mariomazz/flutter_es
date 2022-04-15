import 'package:flutter/material.dart';

class MyMaterialPage extends Page {
  final Widget child;
  MyMaterialPage({
    required this.child,
  }) : super(key: UniqueKey());

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          child,
    );
    // return MaterialPageRoute(settings: this, builder: (context) => child);
  }
}
