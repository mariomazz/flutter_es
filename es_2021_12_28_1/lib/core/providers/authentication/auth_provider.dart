import 'package:deo_demo/core/api_service/identity_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final IdentityService identityService = IdentityService();
  bool _isLoggedIn = true;

  get isLoggedIn {
    return _isLoggedIn;
  }

  String accessToken;
  String get getAccessToken => accessToken ?? '';

  set setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }

  Future<void> logIn() async {
    // ignore: missing_return
    final response = await this.identityService.login().onError((error, stackTrace) {
      // Handle error
    });
    this._isLoggedIn = response != null;
    notifyListeners();
  }

  /*Future<void> logOut() async {
    try {
      final idToken = await secureStorage.read(key: DATABASE_KEY_ACCESSTOKEN);

      if (idToken == null || idToken == '') {
        throw new Exception(
          "Database \'secure storage\' - ID_TOKEN vuoto - null",
        );
      }

      final logoutResponse = await appAuth.endSession(
        new EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: login.postLogoutRedirectUrl,
          serviceConfiguration: login.serviceConfiguration,
          additionalParameters: login.parameter,
        ),
      );

      if (logoutResponse == null) {
        throw new Exception("Nessuna risposta ricevuta - null");
      }

      await clearTokensFromDB();

      notifyListeners();
    } catch (e) {
      log('ECCEZIONE LOGOUT : $e');
    }
  }*/
}
