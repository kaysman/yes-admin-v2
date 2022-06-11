// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-category.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCategoryDTO _$CreateCategoryDTOFromJson(Map<String, dynamic> json) =>
    CreateCategoryDTO(
      title_tm: json['title_tm'] as String,
      title_ru: json['title_ru'] as String?,
      description_tm: json['description_tm'] as String?,
      description_ru: json['description_ru'] as String?,
    );

Map<String, dynamic> _$CreateCategoryDTOToJson(CreateCategoryDTO instance) =>
    <String, dynamic>{
      'title_tm': instance.title_tm,
      'title_ru': instance.title_ru,
      'description_tm': instance.description_tm,
      'description_ru': instance.description_ru,
    };
