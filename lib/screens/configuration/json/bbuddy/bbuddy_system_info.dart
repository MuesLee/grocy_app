import 'package:json_annotation/json_annotation.dart';

import 'bbuddy_version.dart';

part 'bbuddy_system_info.g.dart';

@JsonSerializable(explicitToJson: true)
class BbuddySystemInfo {
  BbuddySystemInfo(this.data);

  BbuddyVersion data;

  factory BbuddySystemInfo.fromJson(Map<String, dynamic> json) => _$BbuddySystemInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BbuddySystemInfoToJson(this);
}
