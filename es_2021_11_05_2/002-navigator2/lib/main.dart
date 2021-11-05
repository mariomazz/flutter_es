import 'package:common/cache/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigator_2/002-04-mobile-and-web-with-auth-and-bootstrap/router/my_app_router_delegate_04.dart';
import 'package:navigator_2/data/auth_repository.dart';
import 'package:navigator_2/data/colors_repository.dart';
import 'package:navigator_2/viewmodels/auth_view_model.dart';
import 'package:navigator_2/viewmodels/colors_view_model.dart';
import 'package:provider/provider.dart';
import '002-04-mobile-and-web-with-auth-and-bootstrap/configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import '002-04-mobile-and-web-with-auth-and-bootstrap/router/my_app_route_information_parser_04.dart';

void main() {
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyAppRouterDelegate delegate;
  late MyAppRouteInformationParser parser;
  late AuthRepository authRepository;
  late ColorsRepository colorsRepository;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepository(Preference());
    colorsRepository = ColorsRepository();
    delegate = MyAppRouterDelegate(authRepository, colorsRepository);
    parser = MyAppRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(authRepository),
        ),
        ChangeNotifierProvider<ColorsViewModel>(
          create: (_) => ColorsViewModel(colorsRepository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: delegate,
        routeInformationParser: parser,
      ),
    );
  }
}
