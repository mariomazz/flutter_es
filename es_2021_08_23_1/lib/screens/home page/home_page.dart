import 'package:chopper/chopper.dart';
import 'package:es_2021_08_23_1/models/posts/post.dart';
import 'package:es_2021_08_23_1/models/users/user.dart';
import 'package:es_2021_08_23_1/screens/posts/posts_screen.dart';
import 'package:es_2021_08_23_1/screens/users/users_screen.dart';
import 'package:es_2021_08_23_1/services/posts/service_posts.dart';
import 'package:es_2021_08_23_1/services/users/service_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    users = updateAndGetUsers();
    posts = updateAndGetPosts();
  }

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
    return await Provider.of<ServicePosts>(context, listen: false).getPosts();
  }

  Future<Response<List<User>>> updateAndGetUsers() async {
    return await Provider.of<ServiceUsers>(context, listen: false).getUsers();
  }

  int number = 0;
  increment() {
    setState(() {
      number += 1;
    });
  }

  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("posts"),
    1: Text("users"),
  };

  Object? currentSelection = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentSelection == 0
            ? Text('posts screen ${number}')
            : Text('users screen ${number}'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CupertinoSlidingSegmentedControl(
                groupValue: currentSelection,
                children: myTabs,
                onValueChanged: (i) {
                  setState(() {
                    currentSelection = i;
                  });
                },
              ),
            ),
          ),
          currentSelection == 0
              ? FutureBuilder<Response<List<Post_>>>(
                  future: posts,
                  builder: (BuildContext context,
                      AsyncSnapshot<Response<List<Post_>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: new Center(
                          child: new CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Expanded(
                        child: Center(
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
                        ),
                      );
                    } else {
                      final posts = snapshot.data!.body ?? <Post_>[];

                      return Expanded(
                        child: RefreshIndicator(
                          child: PostsScreen(posts: posts),
                          onRefresh: refreshPosts,
                        ),
                      );
                    }
                  },
                )
              : FutureBuilder<Response<List<User>>>(
                  future: users,
                  builder: (BuildContext context,
                      AsyncSnapshot<Response<List<User>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: new Center(
                          child: new CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Expanded(
                        child: Center(
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
                        ),
                      );
                    } else {
                      final users = snapshot.data!.body ?? <User>[];

                      return Expanded(
                        child: RefreshIndicator(
                          child: UsersScreen(users: users),
                          onRefresh: refreshUsers,
                        ),
                      );
                    }
                  },
                )
        ],
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: Colors.blue,
          child: InkWell(
            splashColor: Colors.red,
            onTap: () {
              increment();
              print(number);
            },
            child: SizedBox(width: 56, height: 56, child: Icon(Icons.menu)),
          ),
        ),
      ),
    );
  }
}
