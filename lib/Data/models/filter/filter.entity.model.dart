import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:equatable/equatable.dart';

import 'filter.enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter.entity.model.g.dart';

@JsonSerializable()
class FilterEntity extends Equatable {
  final int? id;
  final String? name_tm;
  final String? name_ru;
  final FilterType? type;
  int count;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ProductEntity>? products;
  bool isSelected;

  FilterEntity({
    this.isSelected = false,
    required this.id,
    required this.name_tm,
    required this.name_ru,
    required this.type,
    this.createdAt,
    this.count = 1,
    this.updatedAt,
    this.products
  });

  factory FilterEntity.fromJson(Map<String, dynamic> json) =>
      _$FilterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FilterEntityToJson(this);

  @override
  String toString() => "${this.id} ${this.name_tm} ${this.count}";

  @override
  List<Object?> get props => [this.id];
}
