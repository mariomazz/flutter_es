import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSafeArea extends StatelessWidget {
  CustomSafeArea({Key? key, required this.page}) : super(key: key);
  Widget page;
  final Color colorSafeArea = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorSafeArea,
      child: SafeArea(
        child: page,
      ),
    );
  }
}
