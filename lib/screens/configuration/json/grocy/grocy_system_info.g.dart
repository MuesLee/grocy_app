// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocy_system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrocySystemInfo _$GrocySystemInfoFromJson(Map<String, dynamic> json) {
  return GrocySystemInfo(
    json['grocy_version'] == null
        ? null
        : GrocyVersion.fromJson(json['grocy_version'] as Map<String, dynamic>),
    json['php_version'] as String,
    json['sqlite_version'] as String,
  );
}

Map<String, dynamic> _$GrocySystemInfoToJson(GrocySystemInfo instance) =>
    <String, dynamic>{
      'grocy_version': instance.grocyVersion?.toJson(),
      'php_version': instance.phpVersion,
      'sqlite_version': instance.sqLiteVersion,
    };
