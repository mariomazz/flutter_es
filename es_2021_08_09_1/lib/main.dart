import 'package:myapp/config/routes/route_generator.dart';
import 'package:myapp/services/posts/service_posts.dart';
import 'package:myapp/services/users/service_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
            create: (_) => ServiceUsers.create(),
            dispose: (_, ServiceUsers service) => service.client.dispose()),
        Provider(
            create: (_) => ServicePosts.create(),
            dispose: (_, ServicePosts service) => service.client.dispose()),
      ],
      child: MaterialApp(
        title: 'App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
