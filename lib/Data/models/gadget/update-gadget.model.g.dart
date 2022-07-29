// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update-gadget.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateGadgetModel _$UpdateGadgetModelFromJson(Map<String, dynamic> json) =>
    UpdateGadgetModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GadgetImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => GadgetLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecodeNullable(_$GadgetStatusEnumMap, json['status']),
      location: $enumDecodeNullable(_$GadgetLocationEnumMap, json['location']),
      type: $enumDecodeNullable(_$HomeGadgetTypeEnumMap, json['type']),
      productIds:
          (json['productIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      queue: json['queue'] as int?,
      title: json['title'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$UpdateGadgetModelToJson(UpdateGadgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$HomeGadgetTypeEnumMap[instance.type],
      'links': instance.links,
      'items': instance.items,
      'productIds': instance.productIds,
      'queue': instance.queue,
      'title': instance.title,
      'status': _$GadgetStatusEnumMap[instance.status],
      'location': _$GadgetLocationEnumMap[instance.location],
    };

const _$GadgetStatusEnumMap = {
  GadgetStatus.ACTIVE: 'ACTIVE',
  GadgetStatus.INACTIVE: 'INACTIVE',
};

const _$GadgetLocationEnumMap = {
  GadgetLocation.HOME: 'HOME',
  GadgetLocation.CATEGORY: 'CATEGORY',
};

const _$HomeGadgetTypeEnumMap = {
  HomeGadgetType.TWO_SMALL_CARDS_HORIZONTAL: 'TWO_SMALL_CARDS_HORIZONTAL',
  HomeGadgetType.BANNER_SWIPE_WITH_DOTS: 'BANNER_SWIPE_WITH_DOTS',
  HomeGadgetType.TWO_TO_TWO_WITH_TITLE_AS_IMAGE:
      'TWO_TO_TWO_WITH_TITLE_AS_IMAGE',
  HomeGadgetType.BANNER_FOR_MEN_AND_WOMEN: 'BANNER_FOR_MEN_AND_WOMEN',
  HomeGadgetType.TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT:
      'TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT',
  HomeGadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:
      'CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT',
  HomeGadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE:
      'CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE',
  HomeGadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE:
      'CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE',
  HomeGadgetType.THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT:
      'THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT',
  HomeGadgetType.ONE_IMAGE_WITH_FULL_WIDTH: 'ONE_IMAGE_WITH_FULL_WIDTH',
  HomeGadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:
      'CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT',
  HomeGadgetType.POPULAR: 'POPULAR',
  HomeGadgetType.TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:
      'TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT',
  HomeGadgetType.CIRCLE_ITEMS: 'CIRCLE_ITEMS',
};
