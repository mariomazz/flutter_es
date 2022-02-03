import 'package:flutter/material.dart';
import 'models/page_configuration.dart';
import 'pages.dart';

class MyRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    if (uri.pathSegments.isEmpty) {
      return PageConfiguration(
          key: UniqueKey().toString(), page: Pages.home, path: '/home');
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == 'home') {
        return PageConfiguration(
            key: UniqueKey().toString(), page: Pages.home, path: '/home');
      } else if (first == 'profile') {
        return PageConfiguration(
            key: UniqueKey().toString(), page: Pages.profile, path: '/profile');
      } else {
        return PageConfiguration(
            key: UniqueKey().toString(), page: Pages.error404, path: '/404');
      }
    }
    return PageConfiguration(
        key: UniqueKey().toString(), page: Pages.error404, path: '/404');
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    if (configuration.page == Pages.home) {
      return const RouteInformation(location: '/home');
    } else if (configuration.page == Pages.profile) {
      return const RouteInformation(location: '/profile');
    } else {
      return const RouteInformation(location: '/404');
    }
  }
}
