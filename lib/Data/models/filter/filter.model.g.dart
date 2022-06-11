// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterDTO _$FilterDTOFromJson(Map<String, dynamic> json) => FilterDTO(
      name_tm: json['name_tm'] as String,
      name_ru: json['name_ru'] as String,
      type: $enumDecode(_$FilterTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$FilterDTOToJson(FilterDTO instance) => <String, dynamic>{
      'name_tm': instance.name_tm,
      'name_ru': instance.name_ru,
      'type': _$FilterTypeEnumMap[instance.type],
    };

const _$FilterTypeEnumMap = {
  FilterType.SIZE: 'SIZE',
  FilterType.GENDER: 'GENDER',
  FilterType.COLOR: 'COLOR',
};
