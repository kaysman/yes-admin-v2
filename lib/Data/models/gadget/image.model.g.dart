// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GadgetImage _$GadgetImageFromJson(Map<String, dynamic> json) => GadgetImage(
      link: json['link'] as String?,
      gadgetId: json['gadgetId'] as int?,
      image: json['image'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GadgetImageToJson(GadgetImage instance) =>
    <String, dynamic>{
      'gadgetId': instance.gadgetId,
      'image': instance.image,
      'link': instance.link,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
