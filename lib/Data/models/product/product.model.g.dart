// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      isSelected: json['isSelected'] as bool? ?? false,
      id: json['id'] as int?,
      name_tm: json['name_tm'] as String?,
      name_ru: json['name_ru'] as String?,
      ourPrice: json['ourPrice'] as int?,
      marketPrice: json['marketPrice'] as int?,
      code: json['code'] as String?,
      quantity: json['quantity'] as int?,
      description_tm: json['description_tm'] as String?,
      description_ru: json['description_ru'] as String?,
      sizes: (json['sizes'] as List<dynamic>?)
          ?.map((e) => SizeEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] == null
          ? null
          : CategoryEntity.fromJson(json['category'] as Map<String, dynamic>),
      color: json['color'] == null
          ? null
          : FilterEntity.fromJson(json['color'] as Map<String, dynamic>),
      gender: json['gender'] == null
          ? null
          : FilterEntity.fromJson(json['gender'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : BrandEntity.fromJson(json['brand'] as Map<String, dynamic>),
      market: json['market'] == null
          ? null
          : MarketEntity.fromJson(json['market'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_tm': instance.name_tm,
      'name_ru': instance.name_ru,
      'ourPrice': instance.ourPrice,
      'marketPrice': instance.marketPrice,
      'quantity': instance.quantity,
      'code': instance.code,
      'description_tm': instance.description_tm,
      'description_ru': instance.description_ru,
      'category': instance.category,
      'color': instance.color,
      'gender': instance.gender,
      'brand': instance.brand,
      'market': instance.market,
      'images': instance.images,
      'sizes': instance.sizes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isSelected': instance.isSelected,
    };
