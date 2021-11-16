import 'package:es_2021_11_16_1/configurations/models/page/page.dart';
import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:es_2021_11_16_1/configurations/providers/authentication/authentication_provider.dart';
import 'package:es_2021_11_16_1/configurations/providers/navigations/navigation_provider.dart';
import 'package:es_2021_11_16_1/screens/detail_detail_page.dart';
import 'package:es_2021_11_16_1/screens/detail_page.dart';
import 'package:es_2021_11_16_1/screens/error_page.dart';
import 'package:es_2021_11_16_1/screens/home_page.dart';
import 'package:es_2021_11_16_1/widgets/my_material_page.dart';
import 'package:es_2021_11_16_1/screens/not_logged_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate<Object> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<NavigatorProvider, AuthProvider>(
      builder: (context, navigationDataProvider, authDataProvider, _) {
        final bool isAuth = authDataProvider.isAuth;
        final MyPageModel currentPage = navigationDataProvider.getPage;

        return Navigator(
          pages: [
            if (isAuth)
              if (currentPage.page == Pages.HOME)
                MyMaterialPage(
                  key: HomePage.keyPage,
                  child: HomePage(),
                )
              else if (currentPage.page == Pages.DETAIL)
                MyMaterialPage(
                  key: DetailPage.keyPage,
                  child: DetailPage(),
                )
              else if (currentPage.page == Pages.DETAIL_DETAIL)
                MyMaterialPage(
                  key: DetailDetailPage.keyPage,
                  child: DetailDetailPage(),
                )
              else
                MyMaterialPage(
                  key: ErrorPage.keyPage,
                  child: ErrorPage(),
                )
            else
              MyMaterialPage(
                key: NotLoggedPage.keyPage,
                child: NotLoggedPage(),
              ),
          ],
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        );
      },
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
