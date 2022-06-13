import 'package:json_annotation/json_annotation.dart';
part 'category.model.g.dart';

@JsonSerializable()
class CategoryEntity {
  final int id;
  final String title_tm;
  final String? title_ru;
  final String? description_tm;
  final String? description_ru;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  CategoryEntity({
    required this.id,
    required this.title_tm,
    this.title_ru,
    this.description_tm,
    this.description_ru,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}
