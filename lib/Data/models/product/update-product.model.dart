import 'dart:convert';

import '../filter/size.dart';

class UpdateProductDTO {
  final int id;
  final String? name_tm;
  final String? name_ru;
  final int? ourPrice;
  final int? marketPrice;
  final String? code;
  final int? color_id;
  final int? gender_id;
  final int? brand_id;
  final int? category_id;
  final int? market_id;
  final String? description_tm;
  final String? description_ru;
  final List<CreateSizeDTO>? sizes;

  UpdateProductDTO({
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
    required this.id,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id.toString(),
        'name_tm': this.name_tm,
        'name_ru': this.name_ru,
        'ourPrice': this.ourPrice,
        'marketPrice': this.marketPrice,
        'code': this.code,
        'color_id': this.color_id,
        'gender_id': this.gender_id,
        'brand_id': this.brand_id,
        'category_id': this.category_id,
        'market_id': this.market_id,
        'description_tm': this.description_tm,
        'description_ru': this.description_ru,
        'sizes': json.encode(this.sizes?.map((e) => e.toJson()).toList()),
      };
}
