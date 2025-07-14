import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/product/image.model.dart';
import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.model.g.dart';

@JsonSerializable()
class ProductEntity {
  final int? id;
  final String? name_tm;
  final String? name_ru;
  final int? ourPrice;
  final int? marketPrice;
  final int? quantity;
  final String? code;
  final String? description_tm;
  final String? description_ru;
  final CategoryEntity? category;
  final FilterEntity? color;
  final FilterEntity? gender;
  final BrandEntity? brand;
  final MarketEntity? market;
  final List<ImageEntity>? images;
  final List<SizeEntity>? sizes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool? isSelected;

  ProductEntity({
    this.isSelected = false,
    this.id,
    this.name_tm,
    this.name_ru,
    this.ourPrice,
    this.marketPrice,
    this.code,
    this.quantity,
    this.description_tm,
    this.description_ru,
    this.sizes,
    this.category,
    this.color,
    this.gender,
    this.brand,
    this.market,
    this.images,
    this.createdAt,
    this.updatedAt,
  });


  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}
