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
   String? parentName;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final List<ProductEntity>? products;
   List<CategoryEntity>? subcategories;
  bool isSelected;

  CategoryEntity({
    this.parentName,
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

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((e) => CategoryEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
        isSelected: json['isSelected'] as bool? ?? false,
        id: json['id'] as int?,
        title_tm: json['title_tm'] as String?,
        title_ru: json['title_ru'] as String?,
        description_tm: json['description_tm'] as String?,
        description_ru: json['description_ru'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        parentId: json['parentId'] as int?,
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => ProductEntity.fromJson(e as Map<String, dynamic>))
            .toList(),
        parentName:
            json['parentId'] == null ? json['title_tm'] as String? : null,
      );

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  @override
  List<Object?> get props => [id];

  @override
  String toString() => 'Category: $title_tm $id  parent: $parentName';
}
