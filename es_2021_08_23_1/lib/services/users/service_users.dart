import 'package:chopper/chopper.dart';
import 'package:es_2021_08_23_1/models/users/user.dart';
import 'package:es_2021_08_23_1/services/users/model_users_converter.dart';

part 'service_users.chopper.dart';

@ChopperApi(baseUrl: '/users')
abstract class ServiceUsers extends ChopperService {
  @Get()
  Future<Response<List<User>>> getUsers();
  static ServiceUsers create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$ServiceUsers(),
      ],
      converter: ModelUserConverter(),
      errorConverter: JsonConverter(),
    );

    return _$ServiceUsers(client);
  }
}
