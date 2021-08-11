import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:es_2021_08_09_1/services/users/service_users.dart';
import 'package:es_2021_08_09_1/models/users/user.dart';
import 'package:es_2021_08_09_1/widgets/users/card_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ServiceUsers>(context).getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final String dataJson = snapshot.data!.bodyString;
          final List _users = json.decode(dataJson);
          final List<User> users =
              _users.map((user) => User.fromJson(user)).toList();
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('users'),
                  floating: true,
                ),
                buildUsers(users),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('caricamento'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildUsers(List<User> users) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int i) {
          return CardUsers(
            user: users[i],
          );
        },
        childCount: users.length,
      ),
    );
  }
}
