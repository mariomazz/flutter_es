import 'package:es_2022_02_02_1/core/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routing/my_back_button_dispatcher.dart';
import 'core/routing/my_router_delegate.dart';
import 'core/routing/my_router_information_parser.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MyProviders.providers,
      child: MaterialApp.router(
        
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: MyRouterDelegate.instance,
        routeInformationParser: MyRouteInformationParser(),
        backButtonDispatcher: MyBackButtonDispatcher(),
      ),
    );
  }
}
