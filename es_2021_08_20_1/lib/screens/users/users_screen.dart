

import 'package:flutter/material.dart';
import 'package:pageview/models/users/user.dart';
import 'package:pageview/widgets/users/card_users.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key, required this.users}) : super(key: key);
  final List<User> users;
  @override
  Widget build(BuildContext context) => buildUsersCard();

  Widget buildUsersCard() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          height: 20,
          color: Theme.of(context).primaryColor.withOpacity(0.6),
          indent: 10,
          endIndent: 10,
          thickness: 10,
        );
      },
      itemCount: users.length,
      itemBuilder: (context, index) {
        return CardUsers(
          user: users[index],
        );
      },
    );
  }
}
