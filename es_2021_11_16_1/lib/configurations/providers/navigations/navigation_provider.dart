import 'package:es_2021_11_16_1/configurations/models/page/page.dart';
import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
  Pages page = Pages.HOME;

  Object navigationData = {};

  void setPage(Pages index, {Object? data = ''}) {
    this.navigationData = data!;
    this.page = index;
    notifyListeners();
  }

  MyPage get getPage => MyPage(page: page, data: navigationData);
}
