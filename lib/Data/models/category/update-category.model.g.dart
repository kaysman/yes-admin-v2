// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update-category.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCategoryDTO _$UpdateCategoryDTOFromJson(Map<String, dynamic> json) =>
    UpdateCategoryDTO(
      id: json['id'] as int?,
      title_tm: json['title_tm'] as String?,
      title_ru: json['title_ru'] as String?,
      description_tm: json['description_tm'] as String?,
      description_ru: json['description_ru'] as String?,
      parentId: json['parentId'] as int?,
      backroundImage: json['backroundImage'] as String?,
    );

Map<String, dynamic> _$UpdateCategoryDTOToJson(UpdateCategoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_tm': instance.title_tm,
      'title_ru': instance.title_ru,
      'backroundImage': instance.backroundImage,
      'description_tm': instance.description_tm,
      'description_ru': instance.description_ru,
      'parentId': instance.parentId,
    };
