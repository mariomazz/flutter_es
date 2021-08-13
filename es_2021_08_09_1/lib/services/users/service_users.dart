import 'package:chopper/chopper.dart';
import 'package:myapp/models/users/user.dart';
import 'package:myapp/services/users/model_users_converter.dart';

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
