import 'package:chopper/chopper.dart';
import 'package:pageview/models/posts/post.dart';
import 'package:pageview/services/posts/model_posts_converter.dart';



part 'service_posts.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class ServicePosts extends ChopperService {
  @Get()
  Future<Response<List<Post_>>> getPosts();
  static ServicePosts create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$ServicePosts(),
      ],
      converter: ModelPostConverter(),
      errorConverter: JsonConverter(),
    );

    return _$ServicePosts(client);
  }
}
