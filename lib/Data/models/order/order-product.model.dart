import 'package:json_annotation/json_annotation.dart';
part 'order-product.model.g.dart';

@JsonSerializable()
class OrderProductEntity {
  final int? productId;

  final int? quantity;

  final int? sizeId;
  final int? orderId;

  OrderProductEntity({
    this.productId,
    this.quantity,
    this.sizeId,
    this.orderId,
  });

  factory OrderProductEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductEntityToJson(this);

  @override
  String toString() => '$productId orderId:$orderId';
}
