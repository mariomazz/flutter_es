import 'package:chopper/chopper.dart';
import 'package:es_2021_08_23_1/models/posts/post.dart';
import 'package:es_2021_08_23_1/services/posts/service_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Response<List<Post_>>>? posts;

  int _counter = 0;

  @override
  void initState() {
    super.initState();

    posts = updateAndGetPosts();
  }

  Future<Response<List<Post_>>> updateAndGetPosts() async {
    return Provider.of<ServicePosts>(context).getPosts();
  }

  void refreshPosts() {
    setState(() {
      posts = updateAndGetPosts();
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Response<List<Post_>>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: refreshPosts,
                    child: Text(
                      'You have pushed the button this many times:',
                    ),
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
