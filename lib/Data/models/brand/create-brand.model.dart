import 'package:json_annotation/json_annotation.dart';
part 'create-brand.model.g.dart';

@JsonSerializable()
class CreateBrandDTO {
  final String name;
  final String logo;
  final String? image;
  final bool vip; // default false

  CreateBrandDTO({
    required this.name,
    required this.logo,
    this.image,
    required this.vip,
  });

  factory CreateBrandDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateBrandDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBrandDTOToJson(this);
}
