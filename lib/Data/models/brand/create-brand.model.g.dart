// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-brand.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBrandDTO _$CreateBrandDTOFromJson(Map<String, dynamic> json) =>
    CreateBrandDTO(
      name: json['name'] as String,
      logo: json['logo'] as String,
      image: json['image'] as String?,
      vip: json['vip'] as bool,
    );

Map<String, dynamic> _$CreateBrandDTOToJson(CreateBrandDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'logo': instance.logo,
      'image': instance.image,
      'vip': instance.vip,
    };
