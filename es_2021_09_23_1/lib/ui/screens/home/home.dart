import 'dart:math';
import 'package:es_2021_09_23_1/models/employee/employee.dart';
import 'package:es_2021_09_23_1/providers/database/database_provider.dart';
import 'package:es_2021_09_23_1/storage/database/dao/models/employee/employee_dao.dart';
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
            onPressed: () async {
              bool? delete =
                  await _showConfirmationDialog(context, 'remove all items?');

              if (delete!) {
                deleteAllEmployeeDB();
              }
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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView.builder(
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
            return await _showConfirmationDialog(context, 'remove this item?');
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
      ),
    );
  }

  //methods

  void deleteSingleEmployee(int id) {
    Provider.of<DatabaseProvider>(context, listen: false)
        .getEmployeeDao
        .deleteEmployeeById(id);
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

  Future<bool?> _showConfirmationDialog(BuildContext context, String message) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
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
