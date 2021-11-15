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
      builder: (BuildContext? context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context!).copyWith(
          textScaleFactor:
              MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.5),
        ),
        child: child!,
      ),
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF569D87, swatchColors),
        primaryColor: Color(0xFFC1DFC8),
        secondaryHeaderColor: Color(0xFF569D87),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: MyRouteInformationParser(),
      routerDelegate: MyRouterDelegate(),
    );
  }
}
