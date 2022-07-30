import 'package:json_annotation/json_annotation.dart';
part 'create-gadget-subcategory.model.g.dart';

@JsonSerializable()
class CreateGadgetSubCategory {
  final int categoryId;

  CreateGadgetSubCategory({required this.categoryId});

  factory CreateGadgetSubCategory.fromJson(Map<String, dynamic> json) =>
      _$CreateGadgetSubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGadgetSubCategoryToJson(this);

  @override
  String toString() => 'catId: $categoryId';
}
