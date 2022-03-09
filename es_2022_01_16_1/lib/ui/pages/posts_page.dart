import 'package:flutter/material.dart';
import '../core/api/models/posts.dart';
import '../core/controllers/posts_controller.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsController _controller = PostsController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts Page'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<Posts>(
        stream: _controller.streamPosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listPosts(
                posts: snapshot.data ?? Posts(items: List.empty()));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error => ${snapshot.error?.toString()}'));
            } else if (snapshot.hasData) {
              return listPosts(
                  posts: snapshot.data ?? Posts(items: List.empty()));
            } else {
              return const Center(child: Text('Empty data'));
            }
          } else {
            return Center(child: Text('State: ${snapshot.connectionState}'));
          }
        },
      ),
    );
  }

  Widget listPosts({required Posts posts}) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _controller.clearData();
        });
      },
      child: SizedBox.expand(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: posts.items.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(posts.items[i].title),
            );
          },
        ),
      ),
    );
  }
}
