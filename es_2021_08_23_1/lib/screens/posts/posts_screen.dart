import 'package:es_2021_08_23_1/models/posts/post.dart';
import 'package:es_2021_08_23_1/widgets/posts/card_posts.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key, required this.posts}) : super(key: key);

  final List<Post_> posts;

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) => buildPostsCard();

  Widget buildPostsCard() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        return CardPosts(
          post: widget.posts[index],
        );
      },
    );
  }
}
