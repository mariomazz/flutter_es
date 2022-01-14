import 'dart:async';
import 'package:deo_demo/core/providers/providers.dart';
import 'package:deo_demo/core/routing/my_route_information_parser.dart';
import 'package:deo_demo/core/routing/my_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  /*  LoadingScreen loadingScreen =
      LoadingScreen(duration: Duration(milliseconds: 2500));
  runApp(
    MaterialApp(
      title: 'Load Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loadingScreen,
    ),
  );

  await Future.delayed(loadingScreen.duration, () {}); */
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MyProviders.getProviders(),
      child: MaterialApp.router(
        title: 'Navigator 2.0 + DIO library',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routeInformationParser: MyRouteInformationParser(),
        routerDelegate: MyRouterDelegate(),
      ),
    );
  }
}
