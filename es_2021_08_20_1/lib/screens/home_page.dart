import 'package:chopper/chopper.dart';
import 'package:es_2021_08_20_1/models/posts/post.dart';
import 'package:es_2021_08_20_1/models/users/user.dart';
import 'package:es_2021_08_20_1/screens/posts/posts_screen.dart';
import 'package:es_2021_08_20_1/screens/users/users_screen.dart';
import 'package:es_2021_08_20_1/services/posts/service_posts.dart';
import 'package:es_2021_08_20_1/services/users/service_users.dart';
import 'package:es_2021_08_20_1/widgets/shared/progress-indicator/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final pageController = PageController();

  Future<Response<List<Post_>>>? posts;
  Future<Response<List<User>>>? users;

  Future refreshPosts() async {
    setState(() {
      posts = updateAndGetPosts();
    });
  }

  Future refreshUsers() async {
    setState(() {
      users = updateAndGetUsers();
    });
  }

  Future<Response<List<Post_>>> updateAndGetPosts() async {
    print('get posts');
    return await Provider.of<ServicePosts>(context, listen: false).getPosts();
  }

  Future<Response<List<User>>> updateAndGetUsers() async {
    print('get users');
    return await Provider.of<ServiceUsers>(context, listen: false).getUsers();
  }

  int indexPage = 0;
  @override
  void initState() {
    super.initState();

    users = updateAndGetUsers();
    posts = updateAndGetPosts();

    pageController.addListener(
      () => setState(() {
        indexPage = pageController.page!.round();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    String titleAppBar;
    if (indexPage == 0) {
      titleAppBar = 'page posts';
    } else if (indexPage == 1) {
      titleAppBar = 'page users';
    } else {
      titleAppBar = 'app bar';
    }

    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        elevation: 0,
        title: Text(titleAppBar),
      ),
      body: PageView(
        controller: pageController,
        children: [
          pagePosts(context),
          pageUsers(context),
        ],
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu drawer'),
            decoration: BoxDecoration(
              color: Colors.yellowAccent.shade100,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 40,
            ),
            title: Text('First item'),
            subtitle: Text("This is the 1st item"),
            trailing: Icon(Icons.more_vert),
            onTap: () {},
          ),
          ListTile(
            title: Text('Second item'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Close the menu'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget pagePosts(BuildContext context) {
    return FutureBuilder<Response<List<Post_>>>(
      future: posts,
      builder: (BuildContext context,
          AsyncSnapshot<Response<List<Post_>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 90,
                    color: Colors.red.withOpacity(0.5),
                  ),
                ),
                GestureDetector(
                  onTap: refreshPosts,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.refresh_rounded,
                      size: 110,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          final posts = snapshot.data!.body ?? <Post_>[];

          return LiquidPullToRefresh(
            height: 80,
            color: Theme.of(context).primaryColor,
            child: PostsScreen(posts: posts),
            onRefresh: refreshPosts,
          );
        }
      },
    );
  }

  Widget pageUsers(BuildContext context) {
    return FutureBuilder<Response<List<User>>>(
      future: users,
      builder:
          (BuildContext context, AsyncSnapshot<Response<List<User>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomProgressIndicator();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 90,
                    color: Colors.red.withOpacity(0.5),
                  ),
                ),
                GestureDetector(
                  onTap: refreshUsers,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.refresh_rounded,
                      size: 110,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          final users = snapshot.data!.body ?? <User>[];

          return LiquidPullToRefresh(
            height: 80,
            color: Theme.of(context).primaryColor,
            child: UsersScreen(users: users),
            onRefresh: refreshUsers,
          );
        }
      },
    );
  }

  Widget pageError() {
    return Container(
      child: Center(child: Text('error page build')),
    );
  }
}
