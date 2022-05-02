import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'core/routing/routing.dart';

Future<void> main() async {
  setPathUrlStrategy();
  runApp(const ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Chat Bot Website',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      routeInformationParser: Routing.parser,
      routerDelegate: Routing.delegate,
    );
  }
}
