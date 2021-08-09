// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_factory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    name: json['name'] as String,
    bs: json['bs'] as String,
    catchPhrase: json['catchPhrase'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };
