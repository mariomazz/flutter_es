// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post_ _$PostFromJson(Map<String, dynamic> json) {
  return Post_(
    id: json['id'] as int,
    userId: json['userId'] as int,
    body: json['body'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post_ instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
