import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:es_2021_11_16_1/configurations/routing/navigator.dart';
import 'package:es_2021_11_16_1/widgets/custom_safe_area.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static ValueKey keyPage = ValueKey('home_page');

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      page: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: InkWell(
            onTap: () => MyNavigator.navigateTo(context, Pages.DETAIL),
            child: Text('home page'),
          ),
        ),
      ),
    );
  }
}
