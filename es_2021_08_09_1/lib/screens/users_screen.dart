import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:es_2021_08_09_1/chopper_services/service_users.dart';
import 'package:es_2021_08_09_1/models/user.dart';
import 'package:es_2021_08_09_1/widgets/card_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app bar'),
      ),
      body: FutureBuilder<Response>(
        future: Provider.of<ServiceUsers>(context).getUsers(),
        builder: (context, snapshot) {
          final String dataString = snapshot.data!.bodyString;
          final List _users = json.decode(dataString);
          final List<User> users =
              _users.map((user) => User.fromJson(user)).toList();

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                separatorBuilder: (context, index) => Container(
                      height: 50,
                    ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: CardUsers(
                      user: users[index],
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
