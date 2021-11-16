import 'package:es_2021_11_16_1/configurations/providers/authentication/authentication_provider.dart';
import 'package:es_2021_11_16_1/configurations/providers/navigations/navigation_provider.dart';
import 'package:es_2021_11_16_1/configurations/routing/my_route_information_parser.dart';
import 'package:es_2021_11_16_1/configurations/routing/my_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<NavigatorProvider>(
          create: (BuildContext context) {
            return NavigatorProvider();
          },
        ),
        ListenableProvider<AuthProvider>(create: (BuildContext context) {
          return AuthProvider();
        }),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routeInformationParser: MyRouteInformationParser(),
        routerDelegate: MyRouterDelegate(),
      ),
    );
  }
}
