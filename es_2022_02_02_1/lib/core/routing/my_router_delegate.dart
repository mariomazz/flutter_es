import 'package:es_2022_02_02_1/core/routing/pages.dart';
import 'package:es_2022_02_02_1/ui/pages/home.dart';
import 'package:es_2022_02_02_1/ui/pages/main_screen.dart';
import 'package:es_2022_02_02_1/ui/pages/page404.dart';
import 'package:es_2022_02_02_1/ui/pages/profile.dart';
import 'package:es_2022_02_02_1/ui/widgets/my_material_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'models/page_configuration.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  // singleton

  static final MyRouterDelegate _instance = MyRouterDelegate();
  static MyRouterDelegate get instance => _instance;
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'my_router_delegate_key');
  static GlobalKey<NavigatorState> get navigatorInstance => _navigatorKey;

  // end singleton

  PageConfiguration _routingInformation = PageConfiguration.home();

  PageConfiguration get routingInformation => _routingInformation;

  set _setRoutingInformation(PageConfiguration routingInformation) =>
      _routingInformation = routingInformation;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  PageConfiguration get currentConfiguration => routingInformation;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async =>
      setRoutingInformation(configuration);

  @override
  Future<bool> popRoute() async {
    if (kDebugMode) {
      print('pop override');
    }
    return true;
  }

  Future<void> navTo(PageConfiguration configuration) async =>
      await setNewRoutePath(configuration);

  void setRoutingInformation(PageConfiguration routingInformation) {
    _setRoutingInformation = routingInformation;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: buildPages(),
        onPopPage: (route, data) {
          if (kDebugMode) {
            print('pop Navigator');
          }
          return route.didPop(data);
        },
      );

  List<Page> buildPages() => [
        MyMaterialPage(
          child: const MainScreen(),
        ),
      ];

  Widget widgetFromPageConfiguration(PageConfiguration routingInformation) {
    switch (routingInformation.page) {
      case Pages.home:
        return const HomePage();
      case Pages.profile:
        return const ProfilePage();
      default:
        return const Page404();
    }
  }
}
