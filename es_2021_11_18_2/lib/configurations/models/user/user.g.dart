// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      isEnabled: json['isEnabled'] as bool,
      permissionCode: json['permissionCode'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      fiscalCode: json['fiscalCode'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'isEnabled': instance.isEnabled,
      'permissionCode': instance.permissionCode,
      'email': instance.email,
      'firstName': instance.firstName,
      'fiscalCode': instance.fiscalCode,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
    };
