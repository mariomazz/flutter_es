import 'package:chopper/chopper.dart';
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
