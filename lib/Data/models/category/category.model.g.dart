// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      parentName: json['parentName'] as String?,
      subcategories: (json['subcategories'] as List<dynamic>?)
          ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSelected: json['isSelected'] as bool? ?? false,
      id: json['id'] as int?,
      title_tm: json['title_tm'] as String?,
      title_ru: json['title_ru'] as String?,
      description_tm: json['description_tm'] as String?,
      description_ru: json['description_ru'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      parentId: json['parentId'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_tm': instance.title_tm,
      'title_ru': instance.title_ru,
      'description_tm': instance.description_tm,
      'description_ru': instance.description_ru,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'products': instance.products,
      'subcategories': instance.subcategories,
      'isSelected': instance.isSelected,
    };
