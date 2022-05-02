import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static final ApiService _service = ApiService();
  static ApiService get instance => _service;

  final _baseUrl = "https://ai.asfdemo.it/chat";

  final Dio dio = Dio();

  Future<String?> sendQuestion(String question) async {
    try {
      return (Map.from((await dio.post(_baseUrl,
                  data: {"question": question},
                  options: Options(
                    headers: {"Content-Type": "application/json"},
                  )))
              .data))["answer"]
          .toString();
    } catch (e) {
      if (kDebugMode) {
        print("Errore sendQuestion ApiService => $e");
      }
      return null;
    }
  }
}
