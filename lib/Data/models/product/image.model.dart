import 'package:admin_v2/Data/services/api_client.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image.model.g.dart';

@JsonSerializable()
class ImageEntity {
  final int? id;
  final int? productId;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ImageEntity({
    this.id,
    this.productId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  String? get getFullPathImage => image == null ? null : baseUrl + '/' + image!;

  factory ImageEntity.fromJson(Map<String, dynamic> json) =>
      _$ImageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ImageEntityToJson(this);
}
