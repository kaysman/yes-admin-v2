import 'package:json_annotation/json_annotation.dart';

import '../../services/api_client.dart';
part 'brand.model.g.dart';

@JsonSerializable()
class BrandEntity {
  final int id;
  final String name;
  final String logo;
  final String? image;
  final bool vip;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  bool isSelected;

  BrandEntity({
    this.isSelected = false,
    required this.id,
    required this.name,
    required this.logo,
    this.image,
    required this.vip,
    this.createdAt,
    this.updatedAt,
  });

  String? get fullPathImage => image == null ? null : baseUrl + '/' + image!;
  String? get fullPathLogo => baseUrl + '/' + logo;

  factory BrandEntity.fromJson(Map<String, dynamic> json) =>
      _$BrandEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BrandEntityToJson(this);
}
