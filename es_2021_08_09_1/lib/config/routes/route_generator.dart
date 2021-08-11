import 'package:es_2021_08_09_1/screens/home/home_screen.dart';
import 'package:es_2021_08_09_1/screens/posts/posts_screen.dart';
import 'package:es_2021_08_09_1/screens/users/users_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) {
          return HomeScreen();
        });
      case '/posts':
        return CupertinoPageRoute(builder: (_) {
          return PostsScreen();
        });
      case '/users':
        return CupertinoPageRoute(builder: (_) {
          return UsersScreen();
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Error...'),
        ),
      );
    });
  }
}