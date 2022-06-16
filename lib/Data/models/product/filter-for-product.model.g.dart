// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter-for-product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterForProductDTO _$FilterForProductDTOFromJson(Map<String, dynamic> json) =>
    FilterForProductDTO(
      priceFrom: json['priceFrom'] as int?,
      priceTo: json['priceTo'] as int?,
      color_id: json['color_id'] as int?,
      gender_id: json['gender_id'] as int?,
      quantity: json['quantity'] as int?,
      brand_id: json['brand_id'] as int?,
      category_id: json['category_id'] as int?,
      market_id: json['market_id'] as int?,
      size_id: json['size_id'] as int?,
      lastId: json['lastId'] as int?,
      take: json['take'] as int? ?? 10,
      search: json['search'] as String?,
      next: json['next'] as bool?,
    );

Map<String, dynamic> _$FilterForProductDTOToJson(
        FilterForProductDTO instance) =>
    <String, dynamic>{
      'priceFrom': instance.priceFrom,
      'priceTo': instance.priceTo,
      'color_id': instance.color_id,
      'gender_id': instance.gender_id,
      'quantity': instance.quantity,
      'brand_id': instance.brand_id,
      'category_id': instance.category_id,
      'market_id': instance.market_id,
      'size_id': instance.size_id,
      'lastId': instance.lastId,
      'take': instance.take,
      'search': instance.search,
      'next': instance.next,
    };
