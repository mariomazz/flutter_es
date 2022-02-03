import 'package:es_2022_02_02_1/core/routing/models/page_configuration.dart';
import 'package:es_2022_02_02_1/core/routing/my_router_delegate.dart';
import 'package:es_2022_02_02_1/core/routing/pages.dart';
import 'package:es_2022_02_02_1/ui/widgets/drawer_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static final LocalKey keyPage = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerButton(),
        title: const Text('profile app bar'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async =>
                await Provider.of<MyRouterDelegate>(context, listen: false)
                    .setNewRoutePath(PageConfiguration(
                        key: UniqueKey().toString(),
                        page: Pages.error404,
                        path: '/error404')),
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
