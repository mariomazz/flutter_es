import 'package:chopper/chopper.dart';
import 'package:es_2021_08_09_1/models/posts/post.dart' as post;

part 'service_posts.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class ServicePosts extends ChopperService {
  @Get()
  Future<Response> getPosts();
  static ServicePosts create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$ServicePosts(),
      ],
      converter: JsonConverter(),
    );

    return _$ServicePosts(client);
  }
}
