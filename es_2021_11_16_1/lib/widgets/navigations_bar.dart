import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:es_2021_11_16_1/configurations/routing/navigator.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatelessWidget {
  CustomNavBar({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  Widget build(BuildContext context) {
    return FluidNavBar(
      defaultIndex: index,
      style: FluidNavBarStyle(
        barBackgroundColor: Colors.blue,
      ),
      icons: [
        FluidNavBarIcon(
          icon: Icons.home,
        ),
        FluidNavBarIcon(
          icon: Icons.bookmark_border,
        ),
      ],
      onChange: (index) {
        if (index == 0) {
          MyNavigator.navigateTo(context, Pages.HOME);
        } else if (index == 1) {
          MyNavigator.navigateTo(context, Pages.DETAIL);
        }
      },
    );
  }
}
