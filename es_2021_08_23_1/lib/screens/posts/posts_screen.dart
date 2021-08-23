import 'package:chopper/chopper.dart';
import 'package:es_2021_08_23_1/models/posts/post.dart';
import 'package:es_2021_08_23_1/services/posts/service_posts.dart';
import 'package:es_2021_08_23_1/widgets/posts/card_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  var posts;

  int _counter = 0;

  @override
  void initState() {
    super.initState();

    posts = updateAndGetPosts();
  }

  Future<Response<List<Post_>>> updateAndGetPosts() async {
    var posts = Provider.of<ServicePosts>(context).getPosts();
    return posts;
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
            final posts = snapshot.data!.body;
            print(snapshot.data);
            return PageView.builder(
              itemBuilder: (context, index) {
                return Container();
              },
              //itemCount: posts.length,
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
