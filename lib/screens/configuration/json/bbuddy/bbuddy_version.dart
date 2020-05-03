import 'package:json_annotation/json_annotation.dart';

part 'bbuddy_version.g.dart';

@JsonSerializable()
class BbuddyVersion {
  BbuddyVersion(this.version);

  String version;

  factory BbuddyVersion.fromJson(Map<String, dynamic> json) => _$BbuddyVersionFromJson(json);
  Map<String, dynamic> toJson() => _$BbuddyVersionToJson(this);
}
