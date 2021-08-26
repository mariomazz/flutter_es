import 'package:es_2021_08_20_1/models/users/user.dart';
import 'package:es_2021_08_20_1/widgets/users/card_users.dart';

import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key, required this.users}) : super(key: key);
  final List<User> users;
  @override
  Widget build(BuildContext context) => buildUsersCard();

  Widget buildUsersCard() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return CardUsers(
          user: users[index],
        );
      },
    );
  }
}
