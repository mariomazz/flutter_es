import 'package:es_2021071916/screens/main_screen.dart';
import 'package:es_2021071916/screens/search_persons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) {
          return MainScreen(
            filterList: args != null ? args.toString() : null,
          );
        });

      case '/search/persons':
        return CupertinoPageRoute(builder: (_) {
          return ScreenSearchPersons(
            filterList: args != null ? args.toString() : null,
          );
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
