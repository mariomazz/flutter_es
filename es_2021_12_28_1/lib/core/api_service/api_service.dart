import 'dart:async';
import 'dart:developer';
import 'package:deo_demo/core/providers/authentication/auth_provider.dart';
import 'package:deo_demo/core/models/item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiService {
  ApiService(this.context) {
    this.dio = Dio()..interceptors.add(AppInterceptors(context));
  }
  BuildContext context;
  Dio dio;
  String token = '';

  Map<String, dynamic> headers = {
    'AuthorityId': 12,
    'Authorization': '',
  };

  Future<dynamic> checkAPI({
    Map<dynamic, dynamic> queryParams,
  }) async {
    try {
      final response = await dio.get<dynamic>(
        'https://api-dev.smartpa.cloud/cardmanager/v1/mobile/citizens/fdbc3217-ed2d-4d88-a0bb-5e6a85a9c44b/cards', // API CHECK PATH
        queryParameters: queryParams,
        options: Options(
          headers: this.headers,
        ),
      );
      final jsonData = response.data;
      return jsonData;
    } catch (e) {
      log('ERROR : $e');
    }
  }

  // ignore: missing_return
  Future<GetPostsResponse> getPosts({
    Map<dynamic, dynamic> queryParams,
  }) async {
    try {
      final response = await dio.get<List>(
        'https://jsonplaceholder.typicode.com/posts',
        queryParameters: queryParams,
        options: Options(
          headers: this.headers,
        ),
      );
      final jsonData = response.data;
      return GetPostsResponse.fromJson(jsonData);
    } catch (e) {
      log('ERROR : $e');
    }
  }
}

class AppInterceptors extends Interceptor {
  AppInterceptors(this.context);
  BuildContext context;

  String pathAPI = '';

  @override
  FutureOr<dynamic> onRequest(
      RequestOptions request, RequestInterceptorHandler handler) async {
    log('REQUEST[${request.method}] => PATH: ${request.path}');

    log('HEADERS : ${request.headers}');

    pathAPI = request.path;

    return super.onRequest(request, handler);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log('RESPONSE[${response.statusCode}] => BODY: ${response.data}');

    // for authentication
    if (pathAPI.contains('/api/check') &&
        (response.statusCode != 401 || response.statusCode != 403)) {
      Provider.of<AuthProvider>(context, listen: false).setAuth(context, true);
    }

    return super.onResponse(response, handler);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    // not loggedIn

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      log('Non sei loggato');
      Provider.of<AuthProvider>(context, listen: false).setAuth(context, false);
    }

    return super.onError(err, handler);
  }
}

class GetPostsResponse {
  List<Post> posts;
  GetPostsResponse(this.posts);

  factory GetPostsResponse.fromJson(List<dynamic> json) {
    final List<Post> posts =
        json.map((postJson) => Post.fromJson(postJson)).toList();
    return GetPostsResponse(posts);
  }
}
