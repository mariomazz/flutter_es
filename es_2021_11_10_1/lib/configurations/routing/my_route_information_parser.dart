import 'package:flutter/material.dart';

class MyRouteInformationParser implements RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(
      RouteInformation routeInformation) async {
    print(routeInformation.state);
    return routeInformation;
  }

  @override
  RouteInformation? restoreRouteInformation(Object configuration) {
    throw UnimplementedError();
  }
}
