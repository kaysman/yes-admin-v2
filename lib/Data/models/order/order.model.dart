import 'package:admin_v2/Data/models/order/order-adress.model.dart';
import 'package:admin_v2/Data/models/order/order-product.model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.model.g.dart';

@JsonSerializable()
class OrderEntity {
  final int? id;
  final List<OrderProductEntity>? products;
  final String? status;
  final String? note;
  final int? userId;
  final int? addressId;
  final OrderAdressEntity? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderEntity({
    this.id,
    this.products,
    this.status,
    this.note,
    this.userId,
    this.addressId,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);

  @override
  String toString() => '$status id: $id adress:$address';
}
