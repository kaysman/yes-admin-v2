import 'package:json_annotation/json_annotation.dart';
part 'filter-for-product.model.g.dart';

@JsonSerializable()
class FilterForProductDTO {
  final int? priceFrom;
  final int? priceTo;
  final int? color_id;
  final int? gender_id;
  final int? quantity;
  final int? brand_id;
  final int? category_id;
  final int? market_id;
  final int? size_id;
  int? lastId;
  final int? take;
  final String? search;
  final bool? next;

  FilterForProductDTO({
    this.priceFrom,
    this.priceTo,
    this.color_id,
    this.gender_id,
    this.quantity,
    this.brand_id,
    this.category_id,
    this.market_id,
    this.size_id,
    this.lastId,
    this.take = 10,
    this.search,
    this.next,
  });

  bool get filterArgumentsIsNotNull =>
      (priceFrom != null && priceTo != null) ||
      color_id != null ||
      size_id != null ||
      gender_id != null ||
      quantity != null ||
      brand_id != null ||
      category_id != null ||
      market_id != null;

  factory FilterForProductDTO.fromJson(Map<String, dynamic> json) =>
      _$FilterForProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FilterForProductDTOToJson(this);
}
