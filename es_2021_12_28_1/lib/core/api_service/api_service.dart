import 'dart:async';
import 'dart:developer';
import 'package:deo_demo/core/api_service/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_interceptor.dart';

class ApiService {
  static Dio _client;
  ApiService(this.context) {
    ApiService._client = Dio()..interceptors.add(AuthInterceptors());
  }

  static Dio get client => ApiService._client;

  BuildContext context;
  String baseUrl = 'https://api-$workEnvironmentName.smartpa.cloud';
  Options options = Options(
    headers: {
      'AuthorityId': authorityId,
      'Authorization': '',
    },
  );

  // ignore: missing_return
  Future<dynamic> getWarnings({
    Map<dynamic, dynamic> queryParams,
  }) async {
    try {
      final response = await ApiService.client.get<dynamic>(
        '$baseUrl/portico/v1/warnings',
        queryParameters: queryParams,
        options: options,
      );
      final jsonData = response.data;
      return jsonData;
    } catch (e) {
      log('ERROR : $e');
    }
  }
}
