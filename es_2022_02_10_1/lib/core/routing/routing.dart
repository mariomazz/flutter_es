import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/screens/home_page.dart';
import '../../ui/screens/profile.dart';

class Routing {
  static final Routing _delegate = Routing();
  static Routing get delegate => _delegate;

  final Map<String, Object?> _stackObj = {};

  Map<String, Object?> get obj => _stackObj;

  late final GoRouter _pages = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            pushObj(state.extra);
            return const HomePage();
          }),
      GoRoute(
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) {
            pushObj(state.extra);
            return const ProfilePage();
          }),
    ],
  );

  GoRouter get routes => _pages;

  void pushObj(Object? obj) {
    if (obj != null) {
      _stackObj.addAll({UniqueKey().toString(): obj});
    }
  }
}
