import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create-gadget.model.g.dart';

@JsonSerializable()
class CreateGadgetModel {
  final HomeGadgetType type;
  final List<String> apiUrls;
  final List<String> imageUrls;
  final List<String>? brandIds;
  final List<String>? productIds;
  final int? swiperBannersCount;
  final int queue;

  CreateGadgetModel({
    required this.type,
    required this.apiUrls,
    required this.imageUrls,
    this.brandIds,
    this.productIds,
    this.swiperBannersCount,
    required this.queue,
  });

  factory CreateGadgetModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGadgetModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGadgetModelToJson(this);
}
