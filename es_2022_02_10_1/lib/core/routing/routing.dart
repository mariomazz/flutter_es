import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/screens/home_page.dart';
import '../../ui/screens/not_found.dart';
import '../../ui/screens/profile.dart';

enum Pages { home, profile, notFound }

class Routing {
  static final Routing _instance = Routing(builder: fromPage);
  static Routing get instance => _instance;

  static RouteInformationParser<Object> get parser =>
      instance.routes.routeInformationParser;

  static RouterDelegate<Object> get delegate => instance.routes.routerDelegate;

  static Map<String, Object?> data(Pages page) => instance.obj(page);

  static Widget fromPage(Pages page) {
    switch (page) {
      case Pages.home:
        return const HomePage();
      case Pages.profile:
        return const ProfilePage();
      case Pages.notFound:
        return const NotFound();
      default:
        return const NotFound();
    }
  }

  Routing({required this.builder});

  final Widget Function(Pages page) builder;

  final Map<String, Object?> _stackObj = {};

  final String _initialLocation = "/";

  Map<String, Object?> obj(Pages page) => Map<String, Object?>.from(_stackObj)
    ..removeWhere((k, v) => (k != pathFromPage(page)));

  List<GoRoute> buildRoutes() {
    return Pages.values.map((e) {
      return GoRoute(
        path: pathFromPage(e),
        builder: (BuildContext context, GoRouterState state) {
          pushObj(state.extra, pathFromPage(e));
          return builder(e);
        },
      );
    }).toList();
  }

  late final GoRouter _pages = GoRouter(
    initialLocation: _initialLocation,
    routes: buildRoutes(),
    errorBuilder: (context, state) {
      pushObj(state.extra, pathFromPage(Pages.notFound));
      return const NotFound();
    },
    redirect: (state) {
      if (state.location == _initialLocation) {
        pushObj(state.extra, pathFromPage(Pages.home));
        return pathFromPage(Pages.home);
      }
      return null;
    },
  );

  GoRouter get routes => _pages;

  String pathFromPage(Pages page) {
    return '/${page.name}';
  }

  void pushObj(Object? obj, String path) {
    if (obj != null) {
      _stackObj.addAll({path: obj});
    }
  }
}
