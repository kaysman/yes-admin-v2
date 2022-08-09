// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) => OrderEntity(
      id: json['id'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => OrderProductEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      note: json['note'] as String?,
      userId: json['userId'] as int?,
      addressId: json['addressId'] as int?,
      address: json['address'] == null
          ? null
          : OrderAdressEntity.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OrderEntityToJson(OrderEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
      'status': instance.status,
      'note': instance.note,
      'userId': instance.userId,
      'addressId': instance.addressId,
      'address': instance.address,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
