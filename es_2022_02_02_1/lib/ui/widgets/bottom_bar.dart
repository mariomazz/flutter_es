import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routing/models/page_configuration.dart';
import '../../core/routing/my_router_delegate.dart';
import '../../core/routing/pages.dart';

class BottomBarCs extends StatelessWidget {
  const BottomBarCs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.yellow,
      child: Consumer<MyRouterDelegate>(
        builder: (context, data, _) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                await data.navTo(PageConfiguration.home());
              },
              icon: Icon(
                Icons.home,
                color: data.routingInformation.page == Pages.home
                    ? Colors.red
                    : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () async {
                await data.navTo(PageConfiguration.profile());
              },
              icon: Icon(
                Icons.ac_unit,
                color: data.routingInformation.page == Pages.profile
                    ? Colors.red
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
