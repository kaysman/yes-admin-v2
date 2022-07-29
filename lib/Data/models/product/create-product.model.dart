import 'dart:convert';

import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../filter/size.dart';
part 'create-product.model.g.dart';

@JsonSerializable()
class CreateProductDTO {
  final String name_tm;
  final String name_ru;
  final int ourPrice;
  final int marketPrice;
  final String code;
  final int color_id;
  final int gender_id;
  final int brand_id;
  final int category_id;
  final int market_id;
  final String? description_tm;
  final String? description_ru;
  final List<CreateSizeDTO> sizes;

  CreateProductDTO({
    this.description_tm,
    this.description_ru,
    required this.name_tm,
    required this.name_ru,
    required this.ourPrice,
    required this.marketPrice,
    required this.code,
    required this.color_id,
    required this.gender_id,
    required this.brand_id,
    required this.category_id,
    required this.market_id,
    required this.sizes,
  });
  factory CreateProductDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateProductDTOFromJson(json);

  Map<String, String> toJson() => <String, String>{
        'name_tm': this.name_tm,
        'name_ru': this.name_ru,
        'ourPrice': this.ourPrice.toString(),
        'marketPrice': this.marketPrice.toString(),
        'code': this.code,
        'color_id': this.color_id.toString(),
        'gender_id': this.gender_id.toString(),
        'brand_id': this.brand_id.toString(),
        'category_id': this.category_id.toString(),
        'market_id': this.market_id.toString(),
        'description_tm': this.description_tm.toString(),
        'description_ru': this.description_ru.toString(),
        'sizes': json.encode(this.sizes.map((e) => e.toJson()).toList()),
      };
}
