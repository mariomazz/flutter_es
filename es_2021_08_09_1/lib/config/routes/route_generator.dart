import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/posts/posts_screen.dart';
import 'package:myapp/screens/users/users_screen.dart';
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
          /*if (args is Map<String, bool>) {
            bool checkedMySegnalation = args['checked-my-segnalation']!;

            if (checkedMySegnalation) {
              return Scaffold(
                body: Container(
                  child: Center(
                    child: Text('visualization all segnalation'),
                  ),
                ),
              );
            } else {
              return UsersScreen();
            }
          } else {
            return UsersScreen();
          }*/
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('page not found'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error... ',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'page not found',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
