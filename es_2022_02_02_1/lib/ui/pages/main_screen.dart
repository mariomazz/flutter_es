import 'package:es_2022_02_02_1/core/routing/my_router_delegate.dart';
import 'package:es_2022_02_02_1/ui/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MainScreen({Key? key}) : super(key: key);
  static final LocalKey keyPage = UniqueKey();

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  static void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Selector<MyRouterDelegate, Widget>(
          selector: (context, provider) => provider
              .widgetFromPageConfiguration(provider.currentConfiguration),
          builder: (context, data, _) => data,
        ),
      ),
    );
  }
}
