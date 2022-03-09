import 'package:flutter/material.dart';
import '../../core/api/models/posts.dart';
import '../../core/api/service.dart';
import '../../core/controllers/api_controller.dart';
import '../widgets/api_controller_w.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final ApiController<Posts> _controller = ApiController<Posts>(
    fetchData: () async => await ApiService.service.getPosts(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.clear();
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
      body: ApiControllerW<Posts>(
        stream: _controller.stream,
        onData: (data) => listPosts(posts: data ?? Posts(items: List.empty())),
      ),
    );
  }

  Widget listPosts({required Posts posts}) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _controller.clear();
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
