import 'package:chopper/chopper.dart';
import 'package:myapp/models/posts/post.dart';
import 'package:myapp/services/posts/service_posts.dart';
import 'package:myapp/widgets/posts/card_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response<List<Post_>>>(
      future: Provider.of<ServicePosts>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var posts = snapshot.data!.body ?? [];
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxScrolled) => [
                SliverAppBar(
                  title: Text('posts'),
                  floating: true,
                  snap: true,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ],
              body: RefreshIndicator(
                child: buildPostsListView(posts),
                onRefresh: refresh,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('caricamento'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildPostsSliver(List<Post_> posts) {
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

  Widget buildPostsListView(List<Post_> posts) {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 50,
        width: double.infinity,
      ),
      itemBuilder: (context, i) => CardPosts(
        post: posts[i],
        actionShare: () => Share.share('${posts[i].title}'),
      ),
      itemCount: posts.length,
    );
  }

  Future refresh() async {
    setState(() {});
  }
}
