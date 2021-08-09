import 'package:json_annotation/json_annotation.dart';

part 'geo_factory.g.dart';

@JsonSerializable()
class Geo {
  String lat;
  String lng;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);

  Geo({required this.lat, required this.lng});
}
