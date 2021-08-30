import 'package:chopper/chopper.dart';

part 'registration.chopper.dart';

@ChopperApi(baseUrl: '/registered-users')
abstract class RegistrationService extends ChopperService {
  @Post()
  Future<Response> registrationRequest(
    @Body() Map<String, dynamic> body,
  );

  static RegistrationService create() {
    final client = ChopperClient(
      baseUrl: 'http://localhost:3000',
      services: [
        _$RegistrationService(),
      ],
      converter: JsonConverter(),
    );

    return _$RegistrationService(client);
  }
}
