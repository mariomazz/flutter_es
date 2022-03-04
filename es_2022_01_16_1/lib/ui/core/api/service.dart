import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'models/posts.dart';

class ApiService {
  static final ApiService service = ApiService();

  final Dio _dio = Dio();

  Dio get dio => _dio;

  ApiService();

  Future<Posts> getPosts() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      if (kDebugMode) {
        print('call posts');
      }
      return Posts.fromJson(response.data);
    } catch (e) {
      return Posts(items: []);
    }
  }
}
