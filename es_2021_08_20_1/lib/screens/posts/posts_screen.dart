import 'package:es_2021_08_20_1/models/posts/post.dart';
import 'package:es_2021_08_20_1/widgets/posts/card_posts.dart';

import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key, required this.posts}) : super(key: key);
  final List<Post_> posts;
  @override
  Widget build(BuildContext context) => buildPostsCard();

  Widget buildPostsCard() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return CardPosts(
          post: posts[index],
        );
      },
    );
  }
}
