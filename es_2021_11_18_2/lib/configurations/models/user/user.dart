import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  static const fromJsonFactory = _$UserFromJson;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String id;
  final bool isEnabled;
  final String permissionCode;
  final String email;
  final String firstName;
  final String fiscalCode;
  final String lastName;
  final String phoneNumber;

  User({
    required this.id,
    required this.isEnabled,
    required this.permissionCode,
    required this.email,
    required this.firstName,
    required this.fiscalCode,
    required this.lastName,
    required this.phoneNumber,
  });
}
