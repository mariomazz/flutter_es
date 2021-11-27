import 'package:chopper/chopper.dart';
import 'package:es_2021_11_18_2/configurations/models/user/user.dart';
import 'package:es_2021_11_18_2/services/api_service/auth_interceptors.dart';
import 'package:es_2021_11_18_2/services/api_service/model_converter.dart';
part 'api_service.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  //user census

  @Get(path: '/portico/v1/users/mobile')
  Future<Response<User>> getUserCensus();

  @Post(path: '/portico/v1/users/mobile')
  Future<Response<User>> postUserCensus();

  //user census

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://api-dev.smartpa.cloud',
      services: [
        _$ApiService(),
      ],
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
      interceptors: [
        AuthInterceptor(),
        HttpLoggingInterceptor(),
      ],
    );

    return _$ApiService(client);
  }
}
