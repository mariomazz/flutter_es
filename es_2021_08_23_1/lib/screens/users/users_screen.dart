import 'package:chopper/chopper.dart';
import 'package:es_2021_08_23_1/models/users/user.dart';
import 'package:es_2021_08_23_1/services/users/service_users.dart';
import 'package:es_2021_08_23_1/widgets/users/card_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int number = 0;

  increment() {
    setState(() {
      number += 1;
    });
  }

  Future<Response<List<User>>>? users;

  @override
  void initState() {
    super.initState();

    users = updateAndGetUsers();
  }

  Future refreshUsers() async {
    setState(() {
      users = updateAndGetUsers();
    });
  }

  Future<Response<List<User>>> updateAndGetUsers() async {
    return await Provider.of<ServiceUsers>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Response<List<User>>>(
      future: users,
      builder:
          (BuildContext context, AsyncSnapshot<Response<List<User>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: new Center(
              child: new CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Scaffold(
              body: Center(child: new Text('Error: ${snapshot.error}')));
        } else {
          final users = snapshot.data!.body ?? <User>[];

          return Scrollbar(
            child: new RefreshIndicator(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return CardUsers(
                    user: users[index],
                  );
                },
              ),
              onRefresh: refreshUsers,
            ),
          );
        }
      },
    );
  }
}
