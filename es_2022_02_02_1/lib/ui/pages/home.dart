import 'package:es_2022_02_02_1/core/routing/my_router_delegate.dart';
import 'package:flutter/material.dart';
import '../../core/routing/models/page_configuration.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home app bar'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async => await MyRouterDelegate.instance
                .navTo(PageConfiguration.profile()),
            /*       onPressed: () async {
              await MyRouterDelegate.instance.navigatorKey.currentState
                  ?.push(MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(),
                ),
              ));
            }, */
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
