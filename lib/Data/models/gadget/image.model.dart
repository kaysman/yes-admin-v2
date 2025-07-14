import 'package:admin_v2/Data/services/api_client.dart';
import 'package:json_annotation/json_annotation.dart';
part 'image.model.g.dart';

@JsonSerializable()
class GadgetImage {
  final int? gadgetId;
  final String? image;
  final String? link;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GadgetImage({
    this.link,
    this.gadgetId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  String? get getFullPathImage => image == null ? null : baseUrl + '/' + image!;

  factory GadgetImage.fromJson(Map<String, dynamic> json) =>
      _$GadgetImageFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetImageToJson(this);
}
