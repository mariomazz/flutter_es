import 'package:dio/dio.dart';
import 'package:es_2022_01_29_1/core/api/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  Future<List<Post>> loadPosts() async {
    final response = await Dio()
        .get<List<dynamic>>('https://jsonplaceholder.typicode.com/posts');
    final posts = response.data!.map((e) => Post.fromJson(e)).toList();

    if (response.data == null) {
      return [];
    }
    return posts;
  }

  @override
  void initState() {
    super.initState();
    loadPosts().then((posts) => setState(() => this.posts = posts));
  }

  @override
  void dispose() {
    super.dispose();
    posts.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Home Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (posts.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.grey[200],
        ),
      );
    } else {
      return RefreshIndicator(
        backgroundColor: Colors.grey[200],
        color: Colors.black,
        onRefresh: () async => await loadPosts()
            .then((posts) => setState(() => this.posts = posts)),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: posts.length,
          itemBuilder: (context, i) {
            return slidableWidget(
              index: i,
              child: ListTile(
                key: UniqueKey(),
                title: Text(posts[i].title.toString()),
                leading: Text(posts[i].id.toString()),
                subtitle: Text(posts[i].body.toString()),
                trailing: Text(posts[i].userId.toString()),
              ),
            );
          },
        ),
      );
    }
  }

  Widget slidableWidget({required Widget child, required int index}) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => setState(() => posts.removeAt(index)),
        ),
        children: [
          SlidableAction(
            onPressed: (context) => setState(() => posts.removeAt(index)),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) {},
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),
      child: child,
    );
  }
}
