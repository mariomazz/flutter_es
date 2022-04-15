import '../pages.dart';

class PageConfiguration {
  final Pages page;
  final bool showBottomNavigationBar;

  String get path => '/${page.name}';

  const PageConfiguration({
    required this.page,
    required this.showBottomNavigationBar,
  });

  // home

  static const PageConfiguration _home = PageConfiguration(
    showBottomNavigationBar: true,
    page: Pages.home,
  );

  static PageConfiguration home() {
    return _home;
  }

  // end home

  // profile

  static const PageConfiguration _profile = PageConfiguration(
    showBottomNavigationBar: true,
    page: Pages.profile,
  );

  static PageConfiguration profile() {
    return _profile;
  }

  // end profile

  // error404

  static const PageConfiguration _error404 = PageConfiguration(
    showBottomNavigationBar: false,
    page: Pages.error404,
  );

  static PageConfiguration error404() {
    return _error404;
  }

  // end error404

  static List<PageConfiguration> allPages() {
    return [_home, _profile, _error404];
  }
}
