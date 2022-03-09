import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/api/models/posts.dart';
import '../../core/controllers/posts_controller.dart';
import '../widgets/snapshot_resolving.dart';

enum Size { small, medium, large }

class Stack<T> {
  final List<T> _stack = [];

  List<T> get value => _stack;

  int get length => value.length;

  void push(T item) => _stack.add(item);

  void pop() {
    if (value.isNotEmpty) {
      _stack.removeLast();
    }
  }
}

T stringToEnum<T>(String str, Iterable<T> values) {
  return values.firstWhere(
    (value) => value.toString().split('.')[1] == str,
  );
}

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final ApiController<String> _controller = ApiController<String>();

  final stack = Stack<String>();

  @override
  void initState() {
    stack.pop();
    if (kDebugMode) {
      print(stack.value);
    }
    // var value = stringToEnum("large", Size.values);
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
          return SnapshotResolving(
            snapshot: snapshot,
            onData: listPosts(
              posts: snapshot.data ?? Posts(items: List.empty()),
            ),
            onError: Center(
              child: Text('Error => ${snapshot.error?.toString()}'),
            ),
            onProcessed: const Center(
              child: CircularProgressIndicator(),
            ),
          );
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
