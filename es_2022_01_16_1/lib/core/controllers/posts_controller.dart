import 'dart:async';
import '../api/models/posts.dart';
import '../api/service.dart';

class PostsController {
  PostsController();

  Posts? _posts;

  Stream<Posts> get streamPosts => _fetchPosts();

  Stream<Posts> _fetchPosts() async* {
    if (_posts == null) {
      final posts = await ApiService.service.getPosts();
      _posts = posts;
      yield posts;
    } else {
      yield _posts!;
    }
  }

  void clearData() {
    _posts = null;
  }
}
