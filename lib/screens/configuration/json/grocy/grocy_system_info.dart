import 'package:json_annotation/json_annotation.dart';
import 'grocy_version.dart';

part 'grocy_system_info.g.dart';

@JsonSerializable(explicitToJson: true)
class GrocySystemInfo {
  GrocySystemInfo(this.grocyVersion, this.phpVersion, this.sqLiteVersion);

  @JsonKey(name: 'grocy_version')
  GrocyVersion grocyVersion;
  @JsonKey(name: 'php_version')
  String phpVersion;
  @JsonKey(name: 'sqlite_version')
  String sqLiteVersion;

  factory GrocySystemInfo.fromJson(Map<String, dynamic> json) => _$GrocySystemInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GrocySystemInfoToJson(this);
}
