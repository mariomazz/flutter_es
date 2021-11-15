import 'package:es_2021_11_10_1/screens/qrcode_page.dart';
import 'package:es_2021_11_10_1/screens/error_page.dart';
import 'package:es_2021_11_10_1/screens/home_page.dart';
import 'package:flutter/material.dart';

class MyRouterDelegate extends RouterDelegate<Object> {
  ValueNotifier<int> indexPage = ValueNotifier<int>(0);
  bool popUpValue = false;
  String scanValue = '';
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
                popUpValue: popUpValue,
                scanValue: scanValue,
                navigateToQrcopage: () => indexPage.value = 1,
              ),
            )
          else if (index == 1)
            MaterialPage(
              key: ValueKey('qrcode_page'),
              child: QrCodePage(
                  navigateToHomePage: ({bool? popUpValue, String? scanValue}) {
                if (popUpValue != null) {
                  this.popUpValue = popUpValue;
                }
                if (scanValue != null) {
                  this.scanValue = scanValue;
                }

                indexPage.value = 0;
              }),
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
