import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuth = true;

  void set setAuth(bool isAuth) {
    this.isAuth = isAuth;
    notifyListeners();
  }

  get getIsAuth => isAuth;
}
