// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocy_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrocyVersion _$GrocyVersionFromJson(Map<String, dynamic> json) {
  return GrocyVersion(
    json['Version'] as String,
    json['ReleaseDate'] as String,
  );
}

Map<String, dynamic> _$GrocyVersionToJson(GrocyVersion instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'ReleaseDate': instance.releaseDate,
    };
