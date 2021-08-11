import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:es_2021_08_09_1/models/posts/post.dart';
import 'package:es_2021_08_09_1/services/posts/service_posts.dart';
import 'package:es_2021_08_09_1/widgets/posts/card_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('posts'),
      ),
      body: FutureBuilder<Response>(
        future: Provider.of<ServicePosts>(context).getPosts(),
        builder: (context, snapshot) {
          final String dataJson = snapshot.data!.bodyString;
          final List _posts = json.decode(dataJson);
          final List<Post_> posts =
              _posts.map((post) => Post_.fromJson(post)).toList();

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
                separatorBuilder: (context, index) => Container(
                      height: 50,
                    ),
                itemCount: posts.length,
                itemBuilder: (context, i) {
                  return CardPosts(post: posts[i]);
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
