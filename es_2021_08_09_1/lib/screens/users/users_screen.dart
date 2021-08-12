import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:myapp/services/users/service_users.dart';
import 'package:myapp/models/users/user.dart';
import 'package:myapp/widgets/users/card_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) => [
                SliverAppBar(
                  title: Text('users'),
                  floating: true,
                  snap: true,
                ),
              ],
              body: RefreshIndicator(
                child: buildUsersListView(users),
                onRefresh: refresh,
              ),
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

  Widget buildUsersSliver(List<User> users) {
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

  Widget buildUsersListView(List<User> users) {
    return ListView.builder(
      itemBuilder: (context, i) => CardUsers(
        user: users[i],
      ),
      itemCount: users.length,
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
