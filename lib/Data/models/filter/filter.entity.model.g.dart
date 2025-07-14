// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.entity.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterEntity _$FilterEntityFromJson(Map<String, dynamic> json) => FilterEntity(
      isSelected: json['isSelected'] as bool? ?? false,
      id: json['id'] as int?,
      name_tm: json['name_tm'] as String?,
      name_ru: json['name_ru'] as String?,
      type: $enumDecodeNullable(_$FilterTypeEnumMap, json['type']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      count: json['count'] as int? ?? 1,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterEntityToJson(FilterEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_tm': instance.name_tm,
      'name_ru': instance.name_ru,
      'type': _$FilterTypeEnumMap[instance.type],
      'count': instance.count,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'products': instance.products,
      'isSelected': instance.isSelected,
    };

const _$FilterTypeEnumMap = {
  FilterType.SIZE: 'SIZE',
  FilterType.GENDER: 'GENDER',
  FilterType.COLOR: 'COLOR',
};
