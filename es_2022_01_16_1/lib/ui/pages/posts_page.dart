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
  /* Posts posts = Posts(items: [
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
    Post(body: 'feiuferigeg', title: 'gegergeregr', userId: 8, id: 99),
  ]); */

  void refreshPosts() {
    controller.clearData();
    setState(() {});
  }

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
              ? RefreshIndicator(
                  onRefresh: () async => refreshPosts(),
                  child: SizedBox.expand(
                    child: ListView.builder(
                      itemCount: snapshot.data?.items.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              Text(snapshot.data?.items[index].title ?? 'null'),
                        );
                      },
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
      /* body: SizedBox.expand(
        child: ListView.builder(
          itemCount: posts.items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(posts.items.elementAt(index).title),
            );
          },
        ),
      ), */
    );
  }
}
