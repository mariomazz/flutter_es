import 'package:es_2021_09_23_1/configurations/routing/routing_generator.dart';
import 'package:es_2021_09_23_1/database/dao/employee_dao.dart';
import 'package:es_2021_09_23_1/database/database/database.dart';
import 'package:es_2021_09_23_1/providers/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  final dao = database.employeeDAO;
  runApp(MyApp(dao: dao));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.dao}) : super(key: key);
  final EmployeeDao dao;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) {
            return DatabaseProvider();
          },
          builder: (context, __) {
            Provider.of<DatabaseProvider>(context, listen: false)
                .setEmployeeDao(dao);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: Colors.blue.shade200,
              ),
              initialRoute: '/home',
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          },
        ),
      ],
    );
  }
}
