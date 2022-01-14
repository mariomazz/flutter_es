import 'package:deo_demo/core/costants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DatabaseService {
  
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> saveTokensIntoDB({
    @required String accessToken,
    @required String refreshToken,
    @required String idToken,
    @required String expiryDate,
  }) async {
    if ((accessToken != null && accessToken != '') &&
        (refreshToken != null && refreshToken != '') &&
        (idToken != null && idToken != '') &&
        (expiryDate != null && expiryDate != '')) {
      await secureStorage.write(
        key: DATABASE_KEY_ACCESSTOKEN,
        value: accessToken,
      );
      await secureStorage.write(
        key: DATABASE_KEY_REFRESHTOKEN,
        value: refreshToken,
      );
      await secureStorage.write(
        key: DATABASE_KEY_IDTOKEN,
        value: idToken,
      );
      await secureStorage.write(
        key: DATABASE_KEY_EXPIRYDATE,
        value: expiryDate,
      );
    } else {
      throw new Exception(
          "Non è stato possibile salvare i TOKEN : REFRESH_TOKEN - ACCESS_TOKEN - ID_TOKEN - EXPIRY_DATE");
    }
  }

  Future<String> getRefreshToken() async {
    final refreshToken = await secureStorage.read(key: DATABASE_KEY_REFRESHTOKEN);
    return refreshToken;
  }

  Future<String> getAccessToken() async {
    final refreshToken = await secureStorage.read(key: DATABASE_KEY_ACCESSTOKEN);
    return refreshToken;
  }

  Future<void> clearTokensFromDB() async {
    await secureStorage.deleteAll(iOptions: IOSOptions.defaultOptions);
  /*   await secureStorage.delete(key: DATABASE_KEY_ACCESSTOKEN);
    await secureStorage.delete(key: DATABASE_KEY_REFRESHTOKEN);
    await secureStorage.delete(key: DATABASE_KEY_IDTOKEN);
    await secureStorage.delete(key: DATABASE_KEY_EXPIRYDATE); */
  }
}