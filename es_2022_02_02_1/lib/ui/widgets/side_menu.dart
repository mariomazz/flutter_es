import 'package:es_2022_02_02_1/core/routing/models/page_configuration.dart';
import 'package:es_2022_02_02_1/core/routing/my_router_delegate.dart';
import 'package:es_2022_02_02_1/core/routing/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        children: [
          DrawerHeader(
            margin: const EdgeInsets.only(top: 50),
            child: Image.asset("assets/images/logo.png"),
          ),
          const Center(
            child: Text(
              'Comune di vitulano',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DrawerListTile(
            title: "Page 1",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () async {
              await Provider.of<MyRouterDelegate>(context, listen: false)
                  .setNewRoutePath(
                PageConfiguration(
                  key: UniqueKey().toString(),
                  page: Pages.home,
                  path: '/home',
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Page 2",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () async {
              await Provider.of<MyRouterDelegate>(context, listen: false)
                  .setNewRoutePath(
                PageConfiguration(
                  key: UniqueKey().toString(),
                  page: Pages.profile,
                  path: '/profile',
                ),
              );
            },
          ),
          DrawerListTile(
            title: "Page 3",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () async {
              await Provider.of<MyRouterDelegate>(context, listen: false)
                  .setNewRoutePath(
                PageConfiguration(
                  key: UniqueKey().toString(),
                  page: Pages.error404,
                  path: '/error',
                ),
              );
            },
          ),
          /*    DrawerListTile(
            title: "Page 4",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Page 5",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ), */
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      /*leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),*/
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
