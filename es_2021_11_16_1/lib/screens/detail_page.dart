import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:es_2021_11_16_1/configurations/routing/navigator.dart';
import 'package:es_2021_11_16_1/widgets/custom_safe_area.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);
  static ValueKey keyPage = ValueKey('detail_page');

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      page: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Center(
          child: InkWell(
            onTap: () => MyNavigator.navigateTo(context, Pages.DETAIL_DETAIL),
            child: Text('detail page'),
          ),
        ),
      ),
    );
  }
}
