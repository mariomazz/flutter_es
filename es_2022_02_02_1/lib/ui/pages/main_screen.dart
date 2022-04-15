import 'package:es_2022_02_02_1/core/routing/my_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routing/models/page_configuration.dart';
import '../widgets/bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  /* static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'main_scaffold_key');

  static GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  static void controlMenu() {
    if (!(_scaffoldKey.currentState?.isDrawerOpen ?? false)) {
      _scaffoldKey.currentState?.openDrawer();
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Selector<MyRouterDelegate, PageConfiguration>(
      key: UniqueKey(),
      selector: (context, provider) => provider.currentConfiguration,
      builder: (context, data, _) {
        return Scaffold(
          // key: UniqueKey(),
          bottomNavigationBar:
              data.showBottomNavigationBar ? const BottomBarCs() : null,
          // drawer: const SideMenu(),
          body: MyRouterDelegate.instance.widgetFromPageConfiguration(data),
        );
      },
    );
  }
}
/* Selector<MyRouterDelegate, Widget>(
          selector: (context, provider) => provider
              .widgetFromPageConfiguration(provider.currentConfiguration),
          builder: (context, data, _) => data,
        ), */