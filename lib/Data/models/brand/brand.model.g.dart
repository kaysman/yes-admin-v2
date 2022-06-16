// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandEntity _$BrandEntityFromJson(Map<String, dynamic> json) => BrandEntity(
      isSelected: json['isSelected'] as bool? ?? false,
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      image: json['image'] as String?,
      vip: json['vip'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BrandEntityToJson(BrandEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'image': instance.image,
      'vip': instance.vip,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'isSelected': instance.isSelected,
    };
