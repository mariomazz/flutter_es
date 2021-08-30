import 'package:es_2021_08_29_1/screens/create-new-account.dart';
import 'package:es_2021_08_29_1/screens/forgot-password.dart';
import 'package:es_2021_08_29_1/screens/login-screen.dart';
import 'package:es_2021_08_29_1/screens/registration/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return CupertinoPageRoute(builder: (_) {
          return LoginScreen();
        });
      case '/ForgotPassword':
        return CupertinoPageRoute(builder: (_) {
          return ForgotPassword();
        });
      case '/CreateNewAccount':
        return CupertinoPageRoute(builder: (_) {
          return CreateNewAccount();
        });
      case '/registration':
        return CupertinoPageRoute(builder: (_) {
          return RegistrationScreen();
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
