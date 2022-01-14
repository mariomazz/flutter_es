

import 'package:flutter/foundation.dart';

class LoginResponse {
  String accessToken;
    String refreshToken;
    DateTime accessTokenExpirationDateTime;
    String idToken;
    String tokenType;
    final Map<String, dynamic> authorizationAdditionalParameters;
    Map<String, dynamic> tokenAdditionalParameters;

    LoginResponse({
    @required this.accessToken,
    @required this.refreshToken,
    this.accessTokenExpirationDateTime,
    @required this.idToken,
    this.tokenType,
    this.authorizationAdditionalParameters,
    this.tokenAdditionalParameters,}
  );
}