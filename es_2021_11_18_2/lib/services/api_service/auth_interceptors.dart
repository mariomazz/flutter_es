import 'dart:async';
import 'package:chopper/chopper.dart';

class AuthInterceptor implements RequestInterceptor {
  static const String AUTH_HEADER = "Authorization";
  static const String BEARER = "Bearer ";
  static const String AUTHORITYID = "AuthorityId";

  @override
  FutureOr<Request> onRequest(Request request) async {
    final token = await this._getAccessToken();

    final headers = {
      AUTH_HEADER: BEARER + token,
      AUTHORITYID: '6',
      'Content-Type': 'application/json'
    };

    return request.copyWith(headers: headers);
  }

  Future<String> _getAccessToken() async {
    return 'token';
  }
}
