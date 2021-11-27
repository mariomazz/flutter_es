/* import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider extends ChangeNotifier {
  bool _isBusy = false;
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  String? _codeVerifier;
  String? _authorizationCode;
  String? _refreshToken;
  String? _accessToken;
  DateTime? _expiryDate;
  String? _userId;
  late String? _idToken;
  late String? _token;
  late Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  final TextEditingController _authorizationCodeTextController =
      TextEditingController();
  final TextEditingController _accessTokenTextController =
      TextEditingController();
  final TextEditingController _accessTokenExpirationTextController =
      TextEditingController();

  final TextEditingController _idTokenTextController = TextEditingController();
  final TextEditingController _refreshTokenTextController =
      TextEditingController();

  final String _clientId = 'portici_bologna_mobile';
  final String _redirectUrl = 'it.asf.portici:/oauthredirect';
  final String _issuer =
      'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5';

  final String _postLogoutRedirectUrl = 'it.asf.portici:/';
  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'roles',
    'offline_access',
    'porticiapi',
    'asfappcore'
  ];

  final AuthorizationServiceConfiguration _serviceConfiguration =
      const AuthorizationServiceConfiguration(
    authorizationEndpoint:
        'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/authorize',
    tokenEndpoint:
        'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/token',
    endSessionEndpoint:
        'https://login-dev.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/endsession',
  );

  Future<void> logout() async {
    try {
      _setBusyState();
      await _appAuth.endSession(EndSessionRequest(
        idTokenHint: token,
        postLogoutRedirectUrl: _postLogoutRedirectUrl,
        serviceConfiguration: _serviceConfiguration,
      ));
      await _clearSessionInfo();
    } catch (error) {
      await _clearSessionInfo();
      print(error);
    }
    _clearBusyState();
    notifyListeners();
  }

  Future<void> _clearSessionInfo() async {
    _codeVerifier = null;
    _authorizationCode = null;
    _authorizationCodeTextController.clear();
    _accessToken = null;
    _accessTokenTextController.clear();
    _idToken = null;
    _idTokenTextController.clear();
    _refreshToken = null;
    _refreshTokenTextController.clear();
    _accessTokenExpirationTextController.clear();

/*     final database =
        await $FloorAppDatabase.databaseBuilder('database.db').build();

    final userDataDao = database.userDataDAO;

    await userDataDao.deleteUserData(); */

    notifyListeners();
  }

  Future<void> signInWithAutoCodeExchange(
      {bool preferEphemeralSession = false}) async {
    try {
      _setBusyState();
      final Map<String, String> parameter = {'authorityId': '6'};
      // show that we can also explicitly specify the endpoints rather than getting from the details from the discovery document
      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          issuer: _issuer,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          preferEphemeralSession: preferEphemeralSession,
          additionalParameters: parameter,
        ),
      );

      if (result != null) {
        _processAuthTokenResponse(result);
        log(result.accessToken.toString());
      }
    } catch (_) {
      _clearBusyState();
    }
  }

  void _clearBusyState() {
    _isBusy = false;
  }

  void _setBusyState() {
    _isBusy = true;
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) async {
    try {
      _accessToken = _accessTokenTextController.text = response.accessToken!;
      _idTokenTextController.text = response.idToken!;
      _refreshToken = _refreshTokenTextController.text = response.refreshToken!;
      _accessTokenExpirationTextController.text =
          response.accessTokenExpirationDateTime!.toIso8601String();

      Map<String, dynamic> decodedToken = JwtDecoder.decode(_accessToken!);

//write into database
      /*  final database =
          await $FloorAppDatabase.databaseBuilder('database.db').build();

      final userDataDao = database.userDataDAO;

      userData = UserData.fromJson({
        'id': 0,
        'token': response.accessToken,
        'userId': decodedToken["UserId"],
        'email': decodedToken["preferred_username"],
        'expiryDate': _accessTokenExpirationTextController.text,
      });

      userDataDao.deleteUserData();

      userDataDao.insertUserData(userData!); */

      final expiryDate =
          DateTime.parse(_accessTokenExpirationTextController.text);

      _token = response.accessToken;
      _userId = decodedToken["UserId"];
      _expiryDate = expiryDate;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Gets Expiration Date
  Future<DateTime?> getstoreExpirationDate() async {
    /*  final database =
        await $FloorAppDatabase.databaseBuilder('database.db').build();

    final userDataDao = database.userDataDAO;

    final dataUserFromDB = await userDataDao.getUserDatabyId(0);

    // ignore: unnecessary_null_comparison
    if (dataUserFromDB!.expiryDate == null) {
      return null;
    }
    return DateTime.parse(dataUserFromDB.expiryDate); */
  }
/* 
  Future<String?> getstoreToken() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('database.db').build();

    final userDataDao = database.userDataDAO;

    final dataUserFromDB = await userDataDao.getUserDatabyId(0);

    // ignore: unnecessary_null_comparison
    if (dataUserFromDB!.token == null) {
      return null;
    }
    return dataUserFromDB.token;
  }
 */
  // Gets Preferred User Id
  Future<String?> getstorePreferredUserId() async {
    /*  final database =
        await $FloorAppDatabase.databaseBuilder('database.db').build();

    final userDataDao = database.userDataDAO;

    final dataUserFromDB = await userDataDao.getUserDatabyId(0);

    // ignore: unnecessary_null_comparison
    if (dataUserFromDB!.userId == null) {
      return null;
    }
    return dataUserFromDB.userId;
  } */

    // Gets Preferred User Name
    Future<String?> getstorePreferredEmail() async {
      /*    final database =
        await $FloorAppDatabase.databaseBuilder('database.db').build(); */

      /*   final userDataDao = database.userDataDAO;

    final dataUserFromDB = await userDataDao.getUserDatabyId(0);

    // ignore: unnecessary_null_comparison
    if (dataUserFromDB!.email == null) {
      return null;
    }
    return dataUserFromDB.email;
  } */

      Future<bool> isLoggedIn() async {
        /*    final database =
        await $FloorAppDatabase.databaseBuilder('database.db').build();

    final userDataDao = database.userDataDAO;

    final dataUserFromDB = await userDataDao.getUserDatabyId(0);

    if (dataUserFromDB == null) {
      return false;
    }

    final expiryDateParse = DateTime.parse(dataUserFromDB.expiryDate);

    if (expiryDateParse.isBefore(DateTime.now())) {
      return false;
    } */

        /*  _token = dataUserFromDB.token;
    _userId = dataUserFromDB.userId;

    _expiryDate = expiryDateParse;
    _accessToken = _token;
 */
        return true;
      }

      // ignore: unused_element
      void _autoLogout() {
        if (_authTimer != null) {
          _authTimer!.cancel();
        }

        final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
        _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
      }
    }
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  bool _isBusy = false;
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  String? _codeVerifier;
  String? _authorizationCode;
  String? _refreshToken;
  String? _accessToken;
  String? _idToken;

  final TextEditingController _authorizationCodeTextController =
      TextEditingController();
  final TextEditingController _accessTokenTextController =
      TextEditingController();
  final TextEditingController _accessTokenExpirationTextController =
      TextEditingController();

  final TextEditingController _idTokenTextController = TextEditingController();
  final TextEditingController _refreshTokenTextController =
      TextEditingController();
  String? _userInfo;

  final String _clientId = 'interactive.public';
  final String _redirectUrl = 'io.identityserver.demo:/oauthredirect';
  final String _issuer = 'https://demo.identityserver.io';
  final String _discoveryUrl =
      'https://demo.identityserver.io/.well-known/openid-configuration';
  final String _postLogoutRedirectUrl = 'io.identityserver.demo:/';
  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'email',
    'offline_access',
    'api'
  ];

  final AuthorizationServiceConfiguration _serviceConfiguration =
      const AuthorizationServiceConfiguration(
    authorizationEndpoint: 'https://demo.identityserver.io/connect/authorize',
    tokenEndpoint: 'https://demo.identityserver.io/connect/token',
    endSessionEndpoint: 'https://demo.identityserver.io/connect/endsession',
  );

  Future<void> _endSession() async {
    try {
      _setBusyState();
      await _appAuth.endSession(EndSessionRequest(
          idTokenHint: _idToken,
          postLogoutRedirectUrl: _postLogoutRedirectUrl,
          serviceConfiguration: _serviceConfiguration));
      _clearSessionInfo();
    } catch (_) {}
    _clearBusyState();
  }

  void _clearSessionInfo() {
    _codeVerifier = null;
    _authorizationCode = null;
    _authorizationCodeTextController.clear();
    _accessToken = null;
    _accessTokenTextController.clear();
    _idToken = null;
    _idTokenTextController.clear();
    _refreshToken = null;
    _refreshTokenTextController.clear();
    _accessTokenExpirationTextController.clear();
    _userInfo = null;
  }

  Future<void> _refresh() async {
    try {
      _setBusyState();
      final TokenResponse? result = await _appAuth.token(TokenRequest(
          _clientId, _redirectUrl,
          refreshToken: _refreshToken, issuer: _issuer, scopes: _scopes));
      _processTokenResponse(result);
      await _testApi(result);
    } catch (_) {
      _clearBusyState();
    }
  }

  Future<void> _exchangeCode() async {
    try {
      _setBusyState();
      final TokenResponse? result = await _appAuth.token(TokenRequest(
          _clientId, _redirectUrl,
          authorizationCode: _authorizationCode,
          discoveryUrl: _discoveryUrl,
          codeVerifier: _codeVerifier,
          scopes: _scopes));
      _processTokenResponse(result);
      await _testApi(result);
    } catch (_) {
      _clearBusyState();
    }
  }

  Future<void> _signInWithNoCodeExchange() async {
    try {
      _setBusyState();
      final AuthorizationResponse? result = await _appAuth.authorize(
        AuthorizationRequest(_clientId, _redirectUrl,
            discoveryUrl: _discoveryUrl, scopes: _scopes, loginHint: 'bob'),
      );

      if (result != null) {
        _processAuthResponse(result);
      }
    } catch (_) {
      _clearBusyState();
    }
  }

  Future<void> _signInWithAutoCodeExchange(
      {bool preferEphemeralSession = false}) async {
    try {
      _setBusyState();

      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          serviceConfiguration: _serviceConfiguration,
          scopes: _scopes,
          preferEphemeralSession: preferEphemeralSession,
        ),
      );

      if (result != null) {
        _processAuthTokenResponse(result);
        await _testApi(result);
      }
    } catch (_) {
      _clearBusyState();
    }
  }

  void _clearBusyState() {
    this._isBusy = false;
  }

  void _setBusyState() {
    this._isBusy = true;
  }

  void _processAuthTokenResponse(AuthorizationTokenResponse response) {
    _accessToken = _accessTokenTextController.text = response.accessToken!;
    _idToken = _idTokenTextController.text = response.idToken!;
    _refreshToken = _refreshTokenTextController.text = response.refreshToken!;
    _accessTokenExpirationTextController.text =
        response.accessTokenExpirationDateTime!.toIso8601String();
  }

  void _processAuthResponse(AuthorizationResponse response) {
    _codeVerifier = response.codeVerifier;
    _authorizationCode =
        _authorizationCodeTextController.text = response.authorizationCode!;
    _isBusy = false;
  }

  void _processTokenResponse(TokenResponse? response) {
    _accessToken = _accessTokenTextController.text = response!.accessToken!;
    _idToken = _idTokenTextController.text = response.idToken!;
    _refreshToken = _refreshTokenTextController.text = response.refreshToken!;
    _accessTokenExpirationTextController.text =
        response.accessTokenExpirationDateTime!.toIso8601String();
  }

  Future<void> _testApi(TokenResponse? response) async {
    final http.Response httpResponse = await http.get(
      Uri.parse('https://demo.identityserver.io/api/test'),
      headers: <String, String>{'Authorization': 'Bearer $_accessToken'},
    );

    _userInfo = httpResponse.statusCode == 200 ? httpResponse.body : '';
    this._isBusy = false;
  }
}
