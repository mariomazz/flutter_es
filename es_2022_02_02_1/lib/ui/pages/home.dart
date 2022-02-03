import 'package:es_2022_02_02_1/core/routing/models/page_configuration.dart';
import 'package:es_2022_02_02_1/core/routing/my_router_delegate.dart';
import 'package:es_2022_02_02_1/core/routing/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static final LocalKey keyPage = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home app bar'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async =>
                await Provider.of<MyRouterDelegate>(context, listen: false)
                    .setNewRoutePath(PageConfiguration(key: UniqueKey().toString(), page: Pages.profile, path: '/profile')),
            icon: const Icon(
              Icons.navigate_next,
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
