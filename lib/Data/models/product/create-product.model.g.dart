// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProductDTO _$CreateProductDTOFromJson(Map<String, dynamic> json) =>
    CreateProductDTO(
      description_tm: json['description_tm'] as String?,
      description_ru: json['description_ru'] as String?,
      name_tm: json['name_tm'] as String,
      name_ru: json['name_ru'] as String,
      ourPrice: json['ourPrice'] as int,
      marketPrice: json['marketPrice'] as int,
      code: json['code'] as String,
      color_id: json['color_id'] as int,
      gender_id: json['gender_id'] as int,
      brand_id: json['brand_id'] as int,
      category_id: json['category_id'] as int,
      market_id: json['market_id'] as int,
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => CreateSizeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateProductDTOToJson(CreateProductDTO instance) =>
    <String, dynamic>{
      'name_tm': instance.name_tm,
      'name_ru': instance.name_ru,
      'ourPrice': instance.ourPrice,
      'marketPrice': instance.marketPrice,
      'code': instance.code,
      'color_id': instance.color_id,
      'gender_id': instance.gender_id,
      'brand_id': instance.brand_id,
      'category_id': instance.category_id,
      'market_id': instance.market_id,
      'description_tm': instance.description_tm,
      'description_ru': instance.description_ru,
      'sizes': instance.sizes,
    };
