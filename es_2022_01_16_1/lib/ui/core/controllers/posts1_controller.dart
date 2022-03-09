import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../api/models/posts.dart';
import '../api/service.dart';

class Posts1Controller {
  final StreamController<Posts> _streamController = BehaviorSubject<Posts>();

  Stream<Posts> get stream => _streamController.stream;

  late StreamSubscription<Posts> _streamSubscription;

  Stream<Posts> get allPosts => _fetchPosts();

  Stream<Posts> _fetchPosts() async* {
    yield await ApiService.service.getPosts();
  }

  void refresh() {
    _streamController.sink.addStream(_fetchPosts());
  }

  void init() {
    _streamSubscription = allPosts.listen((event) {
      _streamController.sink.add(event);
    });
  }

  void dispose() {
    _streamController.close();
    _streamSubscription.cancel();
  }
}
