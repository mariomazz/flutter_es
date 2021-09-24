import 'package:es_2021_09_23_1/configurations/routing/routing_generator.dart';
import 'package:es_2021_09_23_1/providers/database/database_provider.dart';
import 'package:es_2021_09_23_1/storage/database/dao/models/employee/employee_dao.dart';
import 'package:es_2021_09_23_1/storage/database/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required AppDatabase database}) : super(key: key) {
    employeeDao = database.employeeDAO;
  }

  EmployeeDao? employeeDao;
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
                .setEmployeeDao(employeeDao!);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: Colors.blue.shade200,
              ),
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          },
        ),
      ],
    );
  }
}
