import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post_ {
  factory Post_.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  int userId;

  int id;

  String title;

  String body;

  Post_({
    required this.id,
    required this.userId,
    required this.body,
    required this.title,
  });
}
