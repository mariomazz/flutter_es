import 'package:deo_demo/core/routing/page.dart';
import 'package:deo_demo/core/routing/pages.dart';
import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
  Pages page = Pages.HOME;

  Object navigationData = {};

  void setPage(Pages index, {Object data = ''}) {
    this.navigationData = data;
    this.page = index;
    notifyListeners();
  }

  void reset() {
    this.page = Pages.HOME;
    this.navigationData = {};
  }

  MyPageModel get getPage => MyPageModel(page: page, data: navigationData);
}
