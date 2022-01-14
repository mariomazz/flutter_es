

import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';

import 'api_service.dart';
import 'db_service.dart';
import 'identity_service.dart';

class AuthInterceptors extends Interceptor {
  AuthInterceptors();
  DatabaseService _dbService = DatabaseService();
  IdentityService _identityService = IdentityService();
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions request, RequestInterceptorHandler handler) async {
    log('REQUEST[${request.method}] => PATH: ${request.path}');

    final accessToken =
        await this._dbService.getAccessToken();
    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    log('HEADERS : ${request.headers}');

    return super.onRequest(request, handler);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log('RESPONSE[${response.statusCode}] => BODY: ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {

      final refreshTokenResponse = await _identityService.refreshToken();
      if (refreshTokenResponse != null) {
        return await _retry(err.requestOptions);
      } else {
        return super.onError(err, handler);
      }
    }

    return super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return ApiService.client.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}