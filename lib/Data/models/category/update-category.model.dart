import 'package:json_annotation/json_annotation.dart';
part 'update-category.model.g.dart';

@JsonSerializable()
class UpdateCategoryDTO {
  final int? id;
  final String? title_tm;
  final String? title_ru;
  final String? backroundImage;
  final String? description_tm;
  final String? description_ru;
  final int? parentId;

  UpdateCategoryDTO({
    required this.id,
    this.title_tm,
    this.title_ru,
    this.description_tm,
    this.description_ru,
    this.parentId,
    this.backroundImage,
  });

  factory UpdateCategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateCategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCategoryDTOToJson(this);
}
