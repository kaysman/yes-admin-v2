import 'package:json_annotation/json_annotation.dart';
part 'create-gadget-product.model.g.dart';

@JsonSerializable()
class CreateGadgetProducts {
  final int productId;

  CreateGadgetProducts({required this.productId});

  factory CreateGadgetProducts.fromJson(Map<String, dynamic> json) =>
      _$CreateGadgetProductsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGadgetProductsToJson(this);

  @override
  String toString() => 'ProductID : $productId';
}
