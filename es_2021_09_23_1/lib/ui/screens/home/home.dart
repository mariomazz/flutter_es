import 'dart:math';
import 'package:es_2021_09_23_1/database/dao/employee_dao.dart';
import 'package:es_2021_09_23_1/database/entity/entity.dart';
import 'package:es_2021_09_23_1/providers/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
              final Employee employee = Employee(
                id: Random().nextInt(300),
                firstName: 'mario',
                email: 'mario857987948@gmail.com',
                lastName: 'mazzarelli',
              );

              addSingleEmployeeDB(employee);
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              deleteAllEmployeeDB();
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
            final employees = snapshot.data ?? [];

            if (employees.isEmpty) {
              return const Center(
                child: Text('nessun elemento presente'),
              );
            }

            return buildListEmployee(employees);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildListEmployee(List<Employee> employee) {
    return ListView.builder(
      itemBuilder: (_, i) => Dismissible(
        background: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.delete, color: Colors.white),
                const Text(
                  'Move to trash',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        confirmDismiss: (DismissDirection dismissDirection) async {
          return await _showConfirmationDialog(context);
        },
        onDismissed: (direction) {
          deleteSingleEmployee(employee[i].id);
        },
        key: UniqueKey(),
        child: Container(
          child: ListTile(
            title: Text(employee[i].firstName),
            subtitle: Text(employee[i].lastName),
            leading: Text(employee[i].id.toString()),
            trailing: Text(employee[i].email),
          ),
        ),
      ),
      itemCount: employee.length,
    );
  }

  void deleteSingleEmployee(int id) {
    EmployeeDao employeeDAO =
        Provider.of<DatabaseProvider>(context, listen: false).getEmployeeDao;
    employeeDAO.deleteEmployeeById(id);
    setState(() {});
    scaffoldMessage('elemento cancellato');
  }

  void deleteAllEmployeeDB() async {
    Provider.of<DatabaseProvider>(context, listen: false)
        .getEmployeeDao
        .deleteEmployee();
    setState(() {});
    scaffoldMessage('tutti gli elementi cancellati');
  }

  void addSingleEmployeeDB(Employee employee) async {
    Provider.of<DatabaseProvider>(context, listen: false)
        .getEmployeeDao
        .insertEmployee(employee);
    setState(() {});
    scaffoldMessage('elemento aggiunto');
  }

  Future<List<Employee>> futureListEmployee() async {
    return Provider.of<DatabaseProvider>(context, listen: false)
        .getEmployeeDao
        .getAllEmployee();
  }

  void scaffoldMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(
          milliseconds: 500,
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('remove this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }
}
