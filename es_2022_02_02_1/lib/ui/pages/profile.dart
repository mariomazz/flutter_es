import 'package:es_2022_02_02_1/core/routing/models/page_configuration.dart';
import 'package:es_2022_02_02_1/core/routing/my_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile app bar'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async =>
                await Provider.of<MyRouterDelegate>(context, listen: false)
                    .setNewRoutePath(PageConfiguration.error404()),
            icon: const Icon(
              Icons.navigate_next,
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
