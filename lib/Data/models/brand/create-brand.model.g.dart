// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-brand.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBrandDTO _$CreateBrandDTOFromJson(Map<String, dynamic> json) =>
    CreateBrandDTO(
      id: json['id'] as int?,
      name: json['name'] as String,
      vip: json['vip'] as bool,
    );

Map<String, dynamic> _$CreateBrandDTOToJson(CreateBrandDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'vip': instance.vip,
    };
