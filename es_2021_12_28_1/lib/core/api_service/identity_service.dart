import 'dart:developer';

import 'package:deo_demo/core/api_service/db_service.dart';
import 'package:deo_demo/core/api_service/login_configurations/login_configurations.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import 'model_response/login_response.dart';

class IdentityService {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final LoginConfigurations loginConfigurations = LoginConfigurations();
  final DatabaseService dbService = DatabaseService();

  Future<LoginResponse> login() async {
    try {
      final loginResponse = await this.appAuth.authorizeAndExchangeCode(
            new AuthorizationTokenRequest(
              loginConfigurations.clientId,
              loginConfigurations.redirectUrl,
              scopes: loginConfigurations.scopes,
              issuer: loginConfigurations.issuer,
              preferEphemeralSession: false,
              serviceConfiguration: loginConfigurations.serviceConfiguration,
              additionalParameters: loginConfigurations.parameter,
            ),
          );

      if (loginResponse == null) {
        throw new Exception("Nessuna risposta ricevuta - null");
      } else {
        final _loginResponse = LoginResponse(
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken,
          idToken: loginResponse.idToken,
          accessTokenExpirationDateTime:
              loginResponse.accessTokenExpirationDateTime,
        );

        await dbService.saveTokensIntoDB(
          accessToken: _loginResponse.accessToken,
          refreshToken: _loginResponse.refreshToken,
          idToken: _loginResponse.idToken,
          expiryDate: _loginResponse.accessTokenExpirationDateTime.toString(),
        );
        return _loginResponse;
      }
      //notifyListeners();
    } catch (e) {
      log('ECCEZIONE LOGIN : $e');

      // FIXME: Return a proper error object
      return Future.error("error");
    }
  }

  Future<LoginResponse> refreshToken() async {
    try {
      final refreshToken = await this.dbService.getRefreshToken();

      if (refreshToken == null || refreshToken == '') {
        throw new Exception(
          "Database \'secure storage\' - REFRESH_TOKEN vuoto - null",
        );
      }

      final TokenResponse refreshResponse = await appAuth.token(
        TokenRequest(
          loginConfigurations.clientId,
          loginConfigurations.redirectUrl,
          discoveryUrl: loginConfigurations.discoveryUrl,
          refreshToken: refreshToken,
          scopes: loginConfigurations.scopes,
          additionalParameters: loginConfigurations.parameter,
        ),
      );

      if (refreshResponse == null) {
        throw new Exception("Nessuna risposta ricevuta - null");
      } else {
        final accessToken = refreshResponse.accessToken;
        final refreshToken = refreshResponse.refreshToken;
        final idToken = refreshResponse.idToken;
        final expiryDate =
            refreshResponse.accessTokenExpirationDateTime.toString();
        
        await dbService.saveTokensIntoDB(
          accessToken: accessToken,
          refreshToken: refreshToken,
          idToken: idToken,
          expiryDate: expiryDate,
        );
        log('token Aggiornato');

        final response = LoginResponse(
          accessToken: refreshResponse.accessToken,
          refreshToken: refreshResponse.refreshToken,
          idToken: refreshResponse.idToken,
          accessTokenExpirationDateTime:
              refreshResponse.accessTokenExpirationDateTime,
        );

        return response;
      }
    } catch (e) {
      log('ECCEZIONE REFESH_TOKEN : $e');
      // FIXME return proper error object
      return Future.error("error");
    }
  }

}