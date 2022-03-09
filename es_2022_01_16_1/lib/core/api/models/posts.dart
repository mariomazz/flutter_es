import 'dart:core';
import 'package:flutter/foundation.dart';

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
    try {
      if (json is List) {
        return Posts(
          items: List<dynamic>.from(json)
              .map(
                (e) => Post(
                  userId: e["userId"] ?? 0,
                  id: e["id"] ?? 0,
                  title: e["title"] ?? "null",
                  body: e["body"] ?? "null",
                ),
              )
              .toList(),
        );
      } else if (json is Map) {
        return Posts(items: [
          Post(
            userId: json["userId"] ?? 0,
            id: json["id"] ?? 0,
            title: json["title"] ?? "null",
            body: json["body"] ?? "null",
          )
        ]);
      } else {
        throw Exception("Type Json Error");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Posts fromJson => $e");
      }
      return Posts(items: List.empty());
    }
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
