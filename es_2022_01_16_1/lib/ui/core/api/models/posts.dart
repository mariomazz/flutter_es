import 'dart:core';

extension PostsExtension on Posts {
  bool validate() {
    if (items.isNotEmpty) {
      return true;
    }

    return false;
  }
}

class Posts {
  final List<Post> items;

  Posts({required this.items});

  factory Posts.fromJson(dynamic json) {
    final listDynamic = List<dynamic>.from(json);
    final posts = listDynamic
        .map(
          (e) => Post(
            userId: e["userId"] ?? 0,
            id: e["id"] ?? 0,
            title: e["title"] ?? "null",
            body: e["body"] ?? "null",
          ),
        )
        .toList();

    return Posts(items: posts);
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}
