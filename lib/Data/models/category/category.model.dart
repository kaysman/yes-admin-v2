import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.model.g.dart';

@JsonSerializable()
class CategoryEntity with EquatableMixin {
  final int? id;
  final String? title_tm;
  final String? title_ru;
  final String? description_tm;
  final String? description_ru;
  final int? parentId;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final List<ProductEntity>? products;
  final List<CategoryEntity>? subcategories;
  bool isSelected;

  CategoryEntity({
    this.subcategories,
    this.isSelected = false,
    required this.id,
    required this.title_tm,
    this.title_ru,
    this.description_tm,
    this.description_ru,
    this.createdAt,
    this.updatedAt,
    this.parentId,
    this.products,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  @override
  List<Object?> get props => [id];

  @override
  String toString() => 'Category: $title_tm $id';
}
