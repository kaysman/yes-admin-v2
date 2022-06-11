import 'package:admin_v2/Data/models/filter/size.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create-product.model.g.dart';

@JsonSerializable()
class CreateProductDTO {
  final String name_tm;
  final String name_ru;
  final String price;
  final int color_id;
  final int gender_id;
  final int quantity;
  final int brand_id;
  final int category_id;
  final int market_id;
  final int code;
  final int? description_tm;
  final int? description_ru;
  final List<CreateSizeDTO>? sizes;

  CreateProductDTO({
    required this.name_tm,
    required this.name_ru,
    required this.price,
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
  factory CreateProductDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductDTOToJson(this);
}
