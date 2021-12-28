import 'package:deo_demo/core/api_service/api_service.dart';
import 'package:deo_demo/core/providers/navigation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuth = false;
  bool get getIsAuth => isAuth;

  Future checkIsAuth(BuildContext context) async {
    /*this is the control method for authentication, call the API and check if the token is valid or not, if it is valid you are authenticated otherwise you are not authenticated, all this always doing it with the token saved in memory*/
    final token = await '';
    if (false) {
      //If() you have the token saved

      await Provider.of<ApiService>(context, listen: false).checkAPI();
    } else {
      //Else you are not logged in
    }

    return Future.value();
  }

  void logIn() async {}

  void logOut() async {
    // clear database - secure storage
  }

  void setAuth(BuildContext context, bool isAuth) {
    this.isAuth = isAuth;
    Provider.of<NavigatorProvider>(context, listen: false)
        .reset(); // this is for navigator 2.0
    notifyListeners();
  }
}
