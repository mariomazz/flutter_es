import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:es_2021_11_27_1/core/api_service/models/post/post.dart';

class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      var mapData = json.decode(response.body);

      switch (BodyType) {
        default:
          var listData = mapData;

          return response.copyWith<BodyType>(
              body: JsonTypeParser.decode<InnerType>(listData));
      }
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: response.body);
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}

typedef T JsonFactory<T>(Map<String, dynamic> json);

class JsonTypeParser {
  static const Map<Type, JsonFactory> factories = {
    PostModel: PostModel.fromJsonFactory,
  };

  static dynamic decode<T>(entity) {
    if (entity is Iterable) return _decodeList<T>(entity);

    if (entity is Map<String, dynamic>) return _decodeMap<T>(entity);

    return entity;
  }

  static T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      throw Exception(T.toString());
    }
    return jsonFactory(values);
  }

  static List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v)).toList();
}
