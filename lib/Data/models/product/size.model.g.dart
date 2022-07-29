// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeEntity _$SizeEntityFromJson(Map<String, dynamic> json) => SizeEntity(
      name_ru: json['name_ru'] as String?,
      id: json['id'] as int?,
      name_tm: json['name_tm'] as String?,
      quantity: json['quantity'] as int?,
      product_id: json['product_id'] as int?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SizeEntityToJson(SizeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'product_id': instance.product_id,
      'name_ru': instance.name_ru,
      'name_tm': instance.name_tm,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
