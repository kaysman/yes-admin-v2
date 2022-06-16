// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.entity.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterEntity _$FilterEntityFromJson(Map<String, dynamic> json) => FilterEntity(
      isSelected: json['isSelected'] as bool? ?? false,
      id: json['id'] as int,
      name_tm: json['name_tm'] as String,
      name_ru: json['name_ru'] as String,
      type: $enumDecode(_$FilterTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$FilterEntityToJson(FilterEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_tm': instance.name_tm,
      'name_ru': instance.name_ru,
      'type': _$FilterTypeEnumMap[instance.type],
      'isSelected': instance.isSelected,
    };

const _$FilterTypeEnumMap = {
  FilterType.SIZE: 'SIZE',
  FilterType.GENDER: 'GENDER',
  FilterType.COLOR: 'COLOR',
};
