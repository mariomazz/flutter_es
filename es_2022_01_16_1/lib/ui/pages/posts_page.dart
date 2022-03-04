import 'package:flutter/material.dart';
import '../core/api/models/posts.dart';
import '../core/controllers/posts_controller.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsController controller = PostsController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.clearData();
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
              //controller.clearData();
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        elevation: 0,
      ),
      body: StreamBuilder<Posts>(
        key: UniqueKey(),
        stream: controller.streamPosts,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SizedBox.expand(
                  child: ListView.builder(
                    itemCount: snapshot.data?.items.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text(snapshot.data?.items[index].title ?? 'null'),
                      );
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
