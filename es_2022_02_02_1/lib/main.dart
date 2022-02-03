import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routing/my_back_button_dispatcher.dart';
import 'core/routing/my_router_delegate.dart';
import 'core/routing/my_router_information_parser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final myRouterDelegate = MyRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<MyRouterDelegate>(
          create: (context) => myRouterDelegate,
          dispose: (context, myRouterDelegate) => myRouterDelegate.dispose(),
        )
      ],
      child: MaterialApp.router(
        key: UniqueKey(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: myRouterDelegate,
        routeInformationParser: MyRouteInformationParser(),
        backButtonDispatcher: MyBackButtonDispatcher(),
      ),
    );
  }
}
