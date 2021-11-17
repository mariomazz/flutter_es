import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:es_2021_11_16_1/configurations/providers/navigations/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNavigator {
  static void navigateTo(BuildContext context, Pages page,
          {Object? data = ''}) =>
      Provider.of<NavigatorProvider>(context, listen: false)
          .setPage(page, data: data!);

  static void pop(BuildContext context, {bool? pop}) =>
      Navigator.pop(context, pop ?? true);
}
