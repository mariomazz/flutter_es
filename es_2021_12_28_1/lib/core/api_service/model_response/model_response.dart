import 'package:deo_demo/core/models/item.dart';

class GetPostsResponse {
  List<Post> posts;
  GetPostsResponse(this.posts);

  factory GetPostsResponse.fromJson(List<dynamic> json) {
    final List<Post> posts =
        json.map((postJson) => Post.fromJson(postJson)).toList();
    return GetPostsResponse(posts);
  }
}
