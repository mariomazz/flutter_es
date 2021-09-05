
import 'package:json_annotation/json_annotation.dart';
import 'package:pageview/models/users/address.dart';
import 'package:pageview/models/users/company.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  int id;

  String name;

  String username;

  String email;

  Address address;

  String phone;

  String website;

  Company company;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.company,
      required this.website});
}
