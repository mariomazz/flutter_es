import 'package:chopper/chopper.dart';
import 'package:es_2021_08_20_1/models/posts/post.dart';
import 'package:es_2021_08_20_1/services/posts/model_posts_converter.dart';


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
