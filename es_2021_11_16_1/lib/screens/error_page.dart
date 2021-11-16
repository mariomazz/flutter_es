import 'package:es_2021_11_16_1/widgets/custom_safe_area.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({Key? key}) : super(key: key);
  static ValueKey keyPage = ValueKey('error_page');

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      page: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('error page'),
        ),
      ),
    );
  }
}
