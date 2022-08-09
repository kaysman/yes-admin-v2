import 'package:json_annotation/json_annotation.dart';
part 'order-adress.model.g.dart';

@JsonSerializable()
class OrderAdressEntity {
  final int? id;
  final String? addressLine1;

  final String? addressLine2;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderAdressEntity({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderAdressEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderAdressEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderAdressEntityToJson(this);

  @override
  String toString() => '$id orderId:$addressLine1';
}
