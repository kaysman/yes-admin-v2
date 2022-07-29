// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gadget.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GadgetEntity _$GadgetEntityFromJson(Map<String, dynamic> json) => GadgetEntity(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GadgetImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => GadgetLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      location: json['location'] as String?,
      type: json['type'] as String?,
      productIds:
          (json['productIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      queue: json['queue'] as int?,
      title: json['title'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$GadgetEntityToJson(GadgetEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'links': instance.links,
      'items': instance.items,
      'productIds': instance.productIds,
      'queue': instance.queue,
      'title': instance.title,
      'status': instance.status,
      'location': instance.location,
    };
