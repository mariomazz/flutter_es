// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_factory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    street: json['street'] as String,
    city: json['city'] as String,
    geo: Geo.fromJson(json['geo'] as Map<String, dynamic>),
    suite: json['suite'] as String,
    zipcode: json['zipcode'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };
