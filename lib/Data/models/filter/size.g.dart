// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSizeDTO _$CreateSizeDTOFromJson(Map<String, dynamic> json) =>
    CreateSizeDTO(
      size_id: json['size_id'] as int?,
      count: json['count'] as int? ?? 1,
    );

Map<String, dynamic> _$CreateSizeDTOToJson(CreateSizeDTO instance) =>
    <String, dynamic>{
      'size_id': instance.size_id,
      'count': instance.count,
    };
