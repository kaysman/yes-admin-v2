import 'package:json_annotation/json_annotation.dart';
part 'create-category.model.g.dart';

@JsonSerializable()
class CreateCategoryDTO {
  final String title_tm;
  final String? title_ru;
  final String? description_tm;
  final String? description_ru;
  final int? parentId;

  CreateCategoryDTO({
    required this.title_tm,
    this.title_ru,
    this.description_tm,
    this.description_ru,
    this.parentId,
  });

  factory CreateCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateCategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCategoryDTOToJson(this);
}
