import 'dart:developer';

import 'package:deo_demo/core/providers/connectivity/connectivity_status.dart';
import 'package:deo_demo/core/providers/authentication/auth_provider.dart';
import 'package:deo_demo/core/providers/navigation/navigation_provider.dart';
import 'package:deo_demo/core/routing/page.dart';
import 'package:deo_demo/core/routing/pages.dart';
import 'package:deo_demo/ui/pages/intro_page.dart';
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

        final bool isAuth = Provider.of<AuthProvider>(context).getIsAuth;

        final ConnectivityStatus connectivityStatus =
            Provider.of<ConnectivityService>(context).getConnectionStatus;

        log(isAuth.toString());

        log(currentPage.page.toString());

        log('${connectivityStatus != null ? connectivityStatus.name : 'null'}');

        return Navigator(
          key: navigatorKey,
          pages: createPages(currentPage, isAuth, connectivityStatus),
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        );
      },
    );
  }

  List<Page> createPages(MyPageModel currentPage, bool isAuth,
      ConnectivityStatus connectivityStatus) {
    List<Page> pages = [];

    if (connectivityStatus == ConnectivityStatus.Cellular ||
        connectivityStatus == ConnectivityStatus.WiFi) {
      if (currentPage.page == Pages.INTRO) {
        pages.add(
          MyMaterialPage(
            IntroPage(),
            key: IntroPage.keyPage,
          ),
        );
      }
    } else {
      if (connectivityStatus == ConnectivityStatus.Offline) {
        pages.add(
          MyMaterialPage(
            WithoutConnectionPage(),
            key: WithoutConnectionPage.keyPage,
          ),
        );
      }
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
