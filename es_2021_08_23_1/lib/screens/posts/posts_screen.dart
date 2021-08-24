import 'package:chopper/chopper.dart';
import 'package:es_2021_08_23_1/models/posts/post.dart';
import 'package:es_2021_08_23_1/services/posts/service_posts.dart';
import 'package:es_2021_08_23_1/widgets/posts/card_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  Future<Response<List<Post_>>>? posts;

  @override
  void initState() {
    super.initState();

    posts = updateAndGetPosts();
  }

  Future refreshPosts() async {
    setState(() {
      posts = updateAndGetPosts();
    });
  }

  Future<Response<List<Post_>>> updateAndGetPosts() async {
    return await Provider.of<ServicePosts>(context, listen: false).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Response<List<Post_>>>(
      future: posts,
      builder: (BuildContext context,
          AsyncSnapshot<Response<List<Post_>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: new Center(
              child: new CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Scaffold(
              body: Center(child: new Text('Error: ${snapshot.error}')));
        } else {
          final posts = snapshot.data!.body ?? <Post_>[];

          return Scrollbar(
            child: new RefreshIndicator(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return CardPosts(
                    post: posts[index],
                  );
                },
              ),
              onRefresh: refreshPosts,
            ),
          );
        }
      },
    );
  }
}
