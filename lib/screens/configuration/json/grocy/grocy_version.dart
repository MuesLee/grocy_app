import 'package:json_annotation/json_annotation.dart';

part 'grocy_version.g.dart';

@JsonSerializable()
class GrocyVersion {
  GrocyVersion(this.version, this.releaseDate);

  @JsonKey(name: 'Version')
  String version;
  @JsonKey(name: 'ReleaseDate')
  String releaseDate;

  factory GrocyVersion.fromJson(Map<String, dynamic> json) => _$GrocyVersionFromJson(json);
  Map<String, dynamic> toJson() => _$GrocyVersionToJson(this);
}
