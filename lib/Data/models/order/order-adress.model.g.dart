// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order-adress.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAdressEntity _$OrderAdressEntityFromJson(Map<String, dynamic> json) =>
    OrderAdressEntity(
      id: json['id'] as int?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OrderAdressEntityToJson(OrderAdressEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
