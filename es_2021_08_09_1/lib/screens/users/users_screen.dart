import 'dart:async';
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
    return FutureBuilder<Response<List<User>>>(
      future: Provider.of<ServiceUsers>(context).getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var users = snapshot.data!.body ?? [];
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) => [
                SliverAppBar(
                  title: Text('users'),
                  floating: true,
                  snap: true,
                  backgroundColor: Theme.of(context).primaryColor,
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
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
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
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 50,
        width: double.infinity,
      ),
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
