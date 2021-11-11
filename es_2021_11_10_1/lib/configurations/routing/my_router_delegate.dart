import 'package:es_2021_11_10_1/screens/detail_page.dart';
import 'package:es_2021_11_10_1/screens/error_page.dart';
import 'package:es_2021_11_10_1/screens/home_page.dart';
import 'package:flutter/material.dart';

class MyRouterDelegate extends RouterDelegate<Object> {
  ValueNotifier<int> indexPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: indexPage,
      builder: (context, index, ___) => Navigator(
        pages: [
          if (index == 0)
            MaterialPage(
              key: ValueKey('home_page'),
              child: HomePage(
                routeDetailPage: () => indexPage.value = 1,
                routeErrorPage: (loggedIn) {
                  if (loggedIn) {
                    indexPage.value = 1;
                  } else {
                    indexPage.value = 2;
                  }
                },
              ),
            )
          else if (index == 1)
            MaterialPage(
              key: ValueKey('detail_page'),
              child: DetailPage(
                routeHomePage: () => indexPage.value = 0,
              ),
            )
          else if (index == 2)
            MaterialPage(
              key: ValueKey('error_page'),
              child: ErrorPage(
                returnHomePage: () => indexPage.value = 0,
              ),
            )
          else
            MaterialPage(
              key: ValueKey('error_page'),
              child: ErrorPage(
                returnHomePage: () => indexPage.value = 0,
              ),
            )
        ],
        onPopPage: (route, result) {
          return false;
        },
      ),
    );
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  Future<bool> popRoute() {
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
