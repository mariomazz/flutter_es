import 'package:deo_demo/core/api_service/env.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class LoginConfigurations {
  final String clientId = 'porticomobileclient';
  final String redirectUrl = 'it.asf.portici:/oauthredirect';
  final String issuer =
      'https://login-$workEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5';

  final List<String> scopes = <String>[
    'asfappusers',
    'openid',
    'profile',
    'roles',
    'offline_access',
    'portico',
    'asfappcore',
  ];

  final String discoveryUrl =
      'https://login-$workEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/.well-known/openid-configuration';

  final String postLogoutRedirectUrl = 'it.asf.portici:/';

  final AuthorizationServiceConfiguration serviceConfiguration =
      const AuthorizationServiceConfiguration(
    authorizationEndpoint:
        'https://login-$workEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/authorize',
    tokenEndpoint:
        'https://login-$workEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/token',
    endSessionEndpoint:
        'https://login-$workEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/endsession',
  );
  final Map<String, String> parameter = {'authorityId': authorityId};
}
