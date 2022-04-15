import 'package:flutter/material.dart';
import 'models/page_configuration.dart';

extension Compare on String {
  bool equals(String other) {
    return identical(this, other);
  }
}

class MyRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    if (uri.pathSegments.isEmpty) {
      return PageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments.first.toLowerCase();
      if (first.equals('home')) {
        return PageConfiguration.home();
      } else if (first.equals('profile')) {
        return PageConfiguration.profile();
      } else {
        return PageConfiguration.error404();
      }
    }
    return PageConfiguration.error404();
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) =>
      RouteInformation(location: configuration.path);
}
