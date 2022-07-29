// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-market.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMarketDTO _$CreateMarketDTOFromJson(Map<String, dynamic> json) =>
    CreateMarketDTO(
      title: json['title'] as String,
      address: json['address'] as String?,
      description: json['description'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      ownerName: json['ownerName'] as String?,
    );

Map<String, dynamic> _$CreateMarketDTOToJson(CreateMarketDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'address': instance.address,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'ownerName': instance.ownerName,
    };
