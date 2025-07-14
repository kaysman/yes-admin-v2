import 'package:json_annotation/json_annotation.dart';
part 'create-brand.model.g.dart';

@JsonSerializable()
class CreateBrandDTO {
  final int? id;
  final String name;
  final bool vip;

  CreateBrandDTO({
    this.id,
    required this.name,
    required this.vip,
  });

  factory CreateBrandDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateBrandDTOFromJson(json);

  Map<String, String> toJson() => <String, String>{
        'id': this.id.toString(),
        'name': this.name,
        'vip': this.vip.toString(),
      };
}
