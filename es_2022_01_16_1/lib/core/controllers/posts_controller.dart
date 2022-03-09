import 'dart:async';
import '../api/models/posts.dart';
import '../api/service.dart';

class ApiController<T> {
  ApiController();

  Posts? _posts;

  Stream<T> get streamPosts => _fetchPosts();

  Stream<T> _fetchPosts() async* {
    if (_posts == null) {
      final posts = await ApiService.service.get(path: 'cjijijr');
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
