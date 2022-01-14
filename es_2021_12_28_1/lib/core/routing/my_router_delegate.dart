import 'dart:developer';

import 'package:deo_demo/core/providers/connectivity/connectivity_status.dart';
import 'package:deo_demo/core/providers/authentication/auth_provider.dart';
import 'package:deo_demo/core/providers/navigation/navigation_provider.dart';
import 'package:deo_demo/core/routing/page.dart';
import 'package:deo_demo/core/routing/pages.dart';
import 'package:deo_demo/ui/pages/home_page.dart';
import 'package:deo_demo/ui/pages/stack_empty.dart';
import 'package:deo_demo/ui/pages/without_connection_page.dart';
import 'package:deo_demo/ui/widgets/my_material_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate<Object> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "main_navigator");

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final MyPageModel currentPage =
            Provider.of<NavigatorProvider>(context).getPage;

        final bool isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn;

        final bool hasConnection =
            Provider.of<ConnectivityService>(context).getHasConnection;

        log(isLoggedIn.toString());

        log(currentPage.page.toString());

        log(hasConnection.toString());

        return Navigator(
          key: navigatorKey,
          pages: createPages(currentPage, isLoggedIn, hasConnection),
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        );
      },
    );
  }

  List<Page> createPages(
      MyPageModel currentPage, bool isLoggedIn, bool hasConnection) {
    List<Page> pages = [];

    if (hasConnection) {
      if (currentPage.page == Pages.HOME) {
        pages.add(
          MyMaterialPage(
            HomePage(),
            key: HomePage.keyPage,
          ),
        );
      }
    } else {
      pages.add(
        MyMaterialPage(
          WithoutConnectionPage(),
          key: WithoutConnectionPage.keyPage,
        ),
      );
    }

    if (pages.isEmpty) {
      pages.add(
        MyMaterialPage(
          StackEmpty(),
          key: StackEmpty.keyPage,
        ),
      );
    }

    return pages;
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
