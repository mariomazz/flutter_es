/* import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(RouterDelegate());

class RouterDelegate extends StatefulWidget {
  @override
  State<RouterDelegate> createState() => _RouterDelegateState();
}

class _RouterDelegateState extends State<RouterDelegate> {
  ValueNotifier<int> indexPage = ValueNotifier(0);

  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Map<int, Color> colors = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      builder: (BuildContext context, value, Widget? child) => MaterialApp(
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFFaed1e6, colors),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Books App',
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Navigator(
            pages: [
              if (indexPage.value == 0)
                MaterialPage(
                  key: HomePage.valueKey,
                  child: HomePage(
                    navigateOnDetailScreen: (value) {
                      if (value == 'mario') {
                        indexPage = ValueNotifier(1);
                      }
                    },
                  ),
                )
              else if (indexPage.value == 1)
                MaterialPage(
                  key: DetailPage.valueKey,
                  child: DetailPage(),
                )
              else
                MaterialPage(
                  key: ErrorPage.valueKey,
                  child: ErrorPage(),
                ),
            ],
            onPopPage: (route, result) {
              final MaterialPage page = route.settings as MaterialPage;

              if (page.key == DetailPage.valueKey) {
                indexPage.value = 0;
              }

              return route.isCurrent;
            },
          ),
        ),
      ),
      valueListenable: indexPage,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.navigateOnDetailScreen}) : super(key: key);

  void Function(String value) navigateOnDetailScreen;

  static const valueKey = ValueKey('home_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: InkWell(
          child: Text('home page'),
          onTap: () {},
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: TextButton(
          onPressed: () {
            navigateOnDetailScreen.call('mario');
          },
          child: Text('detail page'),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const valueKey = ValueKey('detail_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: InkWell(
          child: Text('detail page'),
          onTap: () {},
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);
  static const valueKey = ValueKey('error_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('errore di rotta'),
      ),
    );
  }
}
 */

import 'package:es_2021_11_10_1/configurations/routing/my_router_delegate.dart';
import 'package:es_2021_11_10_1/configurations/routing/my_route_information_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Map<int, Color> swatchColors = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFaed1e6, swatchColors),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: MyRouteInformationParser(),
      routerDelegate: MyRouterDelegate(),
    );
  }
}
