import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'models/posts.dart';

class ApiService {
  static final ApiService service = ApiService();

  final Dio _dio = Dio();

  Dio get dio => _dio;

  ApiService();

  Future<Posts> getPosts({int? id}) async {
    try {
      if (kDebugMode) {
        print('get posts');
      }
      return Posts.fromJson((await dio
              .get('https://jsonplaceholder.typicode.com/posts/${id ?? ''}'))
          .data);
    } catch (e) {
      return Posts(items: []);
    }
  }
}