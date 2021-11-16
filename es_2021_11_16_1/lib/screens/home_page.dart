import 'package:es_2021_11_16_1/configurations/models/pages/pages.dart';
import 'package:es_2021_11_16_1/configurations/providers/authentication/authentication_provider.dart';
import 'package:es_2021_11_16_1/configurations/routing/navigator.dart';
import 'package:es_2021_11_16_1/widgets/custom_safe_area.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static ValueKey keyPage = ValueKey('home_page');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget createBody(BuildContext context, int index) {
    final List<Widget> pages = [
      Center(
        child: InkWell(
          onTap: () => MyNavigator.navigateTo(context, Pages.DETAIL),
          child: Text('detail page'),
        ),
      ),
      Center(
        child: InkWell(
          onTap: () => MyNavigator.navigateTo(context, Pages.DETAIL_DETAIL),
          child: Text('detail detail page'),
        ),
      )
    ];
    return pages[index];
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      page: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: createBody(context, index),
        bottomNavigationBar: FluidNavBar(
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
            setState(() {
              this.index = index;
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: IconButton(
          icon: Icon(
            Icons.logout,
            size: 35.0,
          ),
          onPressed: () =>
              Provider.of<AuthProvider>(context, listen: false).setAuth = false,
        ),
      ),
    );
  }
}
