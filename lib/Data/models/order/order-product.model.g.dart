// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order-product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductEntity _$OrderProductEntityFromJson(Map<String, dynamic> json) =>
    OrderProductEntity(
      productId: json['productId'] as int?,
      quantity: json['quantity'] as int?,
      sizeId: json['sizeId'] as int?,
      orderId: json['orderId'] as int?,
    );

Map<String, dynamic> _$OrderProductEntityToJson(OrderProductEntity instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'sizeId': instance.sizeId,
      'orderId': instance.orderId,
    };
