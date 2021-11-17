import 'package:es_2021_11_16_1/configurations/providers/navigations/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuth = true;

  void setAuth(BuildContext context, bool isAuth) {
    this.isAuth = isAuth;
    Provider.of<NavigatorProvider>(context, listen: false).reset();
    notifyListeners();
  }

  get getIsAuth => isAuth;
}
