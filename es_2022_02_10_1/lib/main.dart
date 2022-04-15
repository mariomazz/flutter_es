import 'package:flutter/material.dart';

import 'core/routing/routing.dart';

Future<void> main() async {
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
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
      ),
      routeInformationParser: Routing.delegate.routes.routeInformationParser,
      routerDelegate: Routing.delegate.routes.routerDelegate,
    );
  }
}
