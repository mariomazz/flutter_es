import 'package:es_2021_11_16_1/configurations/models/page/page.dart';
import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:es_2021_11_16_1/configurations/providers/navigation_provider.dart';
import 'package:es_2021_11_16_1/screens/detail_detail.dart';
import 'package:es_2021_11_16_1/screens/detail_page.dart';
import 'package:es_2021_11_16_1/screens/error_page.dart';
import 'package:es_2021_11_16_1/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate<Object> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorProvider>(
      builder: (context, dataProvider, _) {
        final MyPage currentPage = dataProvider.getPage;
        print(currentPage.page);
        print(currentPage.data);

        return Navigator(
          pages: [
            if (currentPage.page == Pages.HOME)
              MaterialPage(
                key: HomePage.keyPage,
                child: HomePage(),
              )
            else if (currentPage.page == Pages.DETAIL)
              MaterialPage(
                key: DetailPage.keyPage,
                child: DetailPage(),
              )
            else if (currentPage.page == Pages.DETAIL_DETAIL)
              MaterialPage(
                key: DetailDetailPage.keyPage,
                child: DetailDetailPage(),
              )
            else
              MaterialPage(
                key: ErrorPage.keyPage,
                child: ErrorPage(),
              )
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
