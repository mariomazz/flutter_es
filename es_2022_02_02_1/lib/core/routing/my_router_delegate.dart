import 'package:es_2022_02_02_1/core/routing/pages.dart';
import 'package:es_2022_02_02_1/ui/pages/home.dart';
import 'package:es_2022_02_02_1/ui/pages/main_screen.dart';
import 'package:es_2022_02_02_1/ui/pages/page404.dart';
import 'package:es_2022_02_02_1/ui/pages/profile.dart';
import 'package:es_2022_02_02_1/ui/widgets/my_material_page.dart';
import 'package:flutter/material.dart';
import 'models/page_configuration.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  late GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate() {
    _navigatorKey = GlobalKey<NavigatorState>();
    _routingInformation = _initialRoutingInformation;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  @override
  PageConfiguration get currentConfiguration => routingInformation;

  final PageConfiguration _initialRoutingInformation = PageConfiguration(
      key: UniqueKey().toString(), page: Pages.home, path: '/home');

  late PageConfiguration _routingInformation;

  PageConfiguration get routingInformation => _routingInformation;

  void setRoutingConfigurations(PageConfiguration routingInformation) {
    _routingInformation = routingInformation;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: buildPages(),
      onPopPage: (route, _) {
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async =>
      setRoutingConfigurations(configuration);

  List<Page> buildPages() {
    List<Page> pages = [];

    pages.add(
      MyMaterialPage(
        key: MainScreen.keyPage,
        child: MainScreen(),
      ),
    );
    return pages;
  }

  Widget widgetFromPageConfiguration(PageConfiguration configuration) {
    switch (configuration.page) {
      case Pages.home:
        return const HomePage();
      case Pages.profile:
        return const ProfilePage();
      default:
        return const Page404();
    }
  }
}
