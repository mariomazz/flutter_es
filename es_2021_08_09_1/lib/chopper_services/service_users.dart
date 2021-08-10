import 'package:chopper/chopper.dart';
import 'package:es_2021_08_09_1/models/user.dart';

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
      converter: JsonConverter(),
    );

    return _$ServiceUsers(client);
  }
}
