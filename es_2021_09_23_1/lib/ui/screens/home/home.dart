import 'dart:math';
import 'package:es_2021_09_23_1/database/dao/employee_dao.dart';
import 'package:es_2021_09_23_1/database/entity/entity.dart';
import 'package:es_2021_09_23_1/providers/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('database'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              int id;

              id = Random().nextInt(300);

              final Employee employee = Employee(
                id: id,
                firstName: 'mario',
                email: 'mario857987948@gmail.com',
                lastName: 'mazzarelli',
              );

              addSingleEmployeeDB(employee);

              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              deleteAllEmployeeDB();

              setState(() {});
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureListEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('errore'),
            );
          } else if (snapshot.hasData) {
            final employee = snapshot.data ?? [];
            return buildListEmployee(employee);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void deleteAllEmployeeDB() async {
    EmployeeDao employeeDAO =
        Provider.of<DatabaseProvider>(context, listen: false).getEmployeeDao;
    employeeDAO.deleteEmployee();
  }

  void addSingleEmployeeDB(Employee employee) async {
    EmployeeDao employeeDAO =
        Provider.of<DatabaseProvider>(context, listen: false).getEmployeeDao;

    employeeDAO.insertEmployee(employee);
  }

  Future<List<Employee>> futureListEmployee() async {
    EmployeeDao employeeDAO =
        Provider.of<DatabaseProvider>(context, listen: false).getEmployeeDao;

    return employeeDAO.getAllEmployee();
  }

  Widget buildListEmployee(List<Employee> employee) {
    return ListView.builder(
      itemBuilder: (_, i) => ListTile(
        title: Text(employee[i].firstName),
        subtitle: Text(employee[i].lastName),
        leading: Text(employee[i].id.toString()),
      ),
      itemCount: employee.length,
    );
  }
}
