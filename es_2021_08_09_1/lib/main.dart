import 'package:es_2021_08_09_1/chopper_services/service_users.dart';
import 'package:es_2021_08_09_1/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => ServiceUsers.create(),
        dispose: (_, ServiceUsers service) => service.client.dispose(),
        child: MaterialApp(
          title: 'Users',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: UsersScreen(),
        ));
  }
}
