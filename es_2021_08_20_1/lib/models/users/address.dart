import 'package:json_annotation/json_annotation.dart';
import 'package:pageview/models/users/geo.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String street;
  String suite;
  String city;
  String zipcode;

  Geo geo;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  Address(
      {required this.street,
      required this.city,
      required this.geo,
      required this.suite,
      required this.zipcode});
}
