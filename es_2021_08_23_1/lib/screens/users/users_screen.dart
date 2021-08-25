import 'package:es_2021_08_23_1/models/users/user.dart';
import 'package:es_2021_08_23_1/widgets/users/card_users.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key, required this.users}) : super(key: key);
  final List<User> users;

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) => buildUsersCard();

  Widget buildUsersCard() {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return CardUsers(
            user: widget.users[index],
          );
        },
      ),
    );
  }
}
