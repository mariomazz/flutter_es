import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:myapp/models/posts/post.dart' as post;
import 'package:myapp/services/posts/service_posts.dart';
import 'package:myapp/widgets/posts/card_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<ServicePosts>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final String dataJson = snapshot.data!.bodyString;
          final List _posts = json.decode(dataJson);
          final List<post.Post> posts =
              _posts.map((element) => post.Post.fromJson(element)).toList();
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('posts'),
                  floating: true,
                ),
                buildPosts(posts),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('caricamento'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildPosts(List<post.Post> posts) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int i) {
          return CardPosts(
            post: posts[i],
          );
        },
        childCount: posts.length,
      ),
    );
  }
}
