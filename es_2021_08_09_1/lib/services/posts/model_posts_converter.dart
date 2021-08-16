import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:myapp/models/posts/post.dart';

class ModelPostConverter implements Converter {
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
      var mapData = json.decode(body);
      var postsMap = mapData as List;
      var posts = postsMap.map((post) => Post_.fromJson(post)).toList();
      return response.copyWith<BodyType>(body: posts as BodyType);
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: body);
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}
