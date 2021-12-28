import 'package:deo_demo/core/api_service/api_service.dart';
import 'package:deo_demo/core/providers/authentication/auth_provider.dart';
import 'package:deo_demo/core/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> items;

  void resetElement() {
    setState(() {
      items = null;
    });
  }

  Future<void> getItems() async {
    final response =
        await Provider.of<ApiService>(context, listen: false).getPosts();

    setState(() {
      items = response.posts;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, bool>(
      selector: (_, provider) => provider.getIsAuth,
      builder: (_, isAuth, __) {
        /* if (isAuth) { */
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: items != null ? Text('HOME PAGE') : Text('CARICA ELEMENTI'),
            actions: [
              items != null
                  ? InkWell(
                      onTap: () async => resetElement(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.restore),
                      ),
                    )
                  : Container(),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isAuth
                      ? Icon(Icons.logout, color: Colors.green)
                      : Icon(Icons.login, color: Colors.red),
                ),
              )
            ],
          ),
          body: items != null
              ? buildListItems()
              : Center(
                  child: ElevatedButton(
                    onPressed: () => getItems(),
                    child: Text('Carica'),
                  ),
                ),
        );
        /* }  else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('NON SEI LOGGATO'),
            ),
            body: Center(
              child: Text('NON SEI LOGGATO'),
            ),
          );
        } */
      },
    );
  }

  Widget buildListItems() {
    return RefreshIndicator(
      onRefresh: () async => getItems(),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(items[index].id.toString()),
            title: Text(items[index].title),
            subtitle: Text(items[index].body),
            trailing: Text(items[index].userId.toString()),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
