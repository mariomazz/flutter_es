import 'package:es_2021_11_16_1/configurations/providers/authentication/authentication_provider.dart';
import 'package:es_2021_11_16_1/configurations/providers/navigations/navigation_provider.dart';
import 'package:es_2021_11_16_1/configurations/providers/state_bav_bar/state_nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProviders {
  static List<ListenableProvider> getProviders() => [
        ListenableProvider<NavigatorProvider>(
          create: (BuildContext context) {
            return NavigatorProvider();
          },
        ),
        ListenableProvider<AuthProvider>(
          create: (BuildContext context) {
            return AuthProvider();
          },
        ),
        ListenableProvider<StateNavBarProvider>(
          create: (BuildContext context) {
            return StateNavBarProvider();
          },
        )
      ];
}
