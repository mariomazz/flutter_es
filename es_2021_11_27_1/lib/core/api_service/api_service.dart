import 'package:chopper/chopper.dart';
import 'package:es_2021_11_27_1/core/api_service/model_converter.dart';
import 'package:es_2021_11_27_1/core/api_service/models/post/post.dart';
part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Get(path: '/posts')
  Future<Response<List<PostModel>>> getPosts();

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$ApiService(),
      ],
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$ApiService(client);
  }
}
