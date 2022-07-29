// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-gadget.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGadgetModel _$CreateGadgetModelFromJson(Map<String, dynamic> json) =>
    CreateGadgetModel(
      links:
          (json['links'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: $enumDecodeNullable(_$GadgetStatusEnumMap, json['status']),
      location: $enumDecodeNullable(_$GadgetLocationEnumMap, json['location']),
      type: $enumDecodeNullable(_$HomeGadgetTypeEnumMap, json['type']),
      productIds: (json['productIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      queue: json['queue'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CreateGadgetModelToJson(CreateGadgetModel instance) =>
    <String, dynamic>{
      'type': _$HomeGadgetTypeEnumMap[instance.type],
      'links': instance.links,
      'productIds': instance.productIds,
      'queue': instance.queue,
      'title': instance.title,
      'status': _$GadgetStatusEnumMap[instance.status],
      'location': _$GadgetLocationEnumMap[instance.location],
    };
