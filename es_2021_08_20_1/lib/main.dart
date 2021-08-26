import 'package:es_2021_08_20_1/config/routes/route_generator.dart';
import 'package:es_2021_08_20_1/services/posts/service_posts.dart';
import 'package:es_2021_08_20_1/services/users/service_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => ServicePosts.create(),
          dispose: (_, ServicePosts service) => service.client.dispose(),
        ),
        Provider(
          create: (_) => ServiceUsers.create(),
          dispose: (_, ServiceUsers service) => service.client.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green.shade300,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
