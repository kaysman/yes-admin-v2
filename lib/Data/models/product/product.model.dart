import 'package:admin_v2/Data/models/filter/size.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.model.g.dart';

@JsonSerializable()
class ProductEntity {
  final int id;
  final String name_tm;
  final String name_ru;
  final int ourPrice;
  final int marketPrice;
  final int color_id;
  final int gender_id;
  final int quantity;
  final int brand_id;
  final int category_id;
  final int market_id;
  final String code;
  final String? description_tm;
  final String? description_ru;
  final List<CreateSizeDTO>? sizes;
  bool isSelected;

  ProductEntity({
    this.isSelected = false,
    required this.id,
    required this.name_tm,
    required this.name_ru,
    required this.ourPrice,
    required this.marketPrice,
    required this.color_id,
    required this.gender_id,
    required this.brand_id,
    required this.category_id,
    required this.market_id,
    required this.code,
    required this.quantity,
    this.description_tm,
    this.description_ru,
    this.sizes,
  });
  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}
