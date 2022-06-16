// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketEntity _$MarketEntityFromJson(Map<String, dynamic> json) => MarketEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      logo: json['logo'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      ownerName: json['ownerName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MarketEntityToJson(MarketEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'logo': instance.logo,
      'address': instance.address,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'ownerName': instance.ownerName,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
