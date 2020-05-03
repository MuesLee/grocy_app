// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bbuddy_system_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BbuddySystemInfo _$BbuddySystemInfoFromJson(Map<String, dynamic> json) {
  return BbuddySystemInfo(
    json['data'] == null
        ? null
        : BbuddyVersion.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BbuddySystemInfoToJson(BbuddySystemInfo instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };
