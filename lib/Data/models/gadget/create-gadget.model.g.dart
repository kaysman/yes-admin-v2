// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-gadget.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGadgetModel _$CreateGadgetModelFromJson(Map<String, dynamic> json) =>
    CreateGadgetModel(
      type: $enumDecode(_$HomeGadgetTypeEnumMap, json['type']),
      apiUrls:
          (json['apiUrls'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      brandIds: (json['brandIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      productIds: (json['productIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      swiperBannersCount: json['swiperBannersCount'] as int?,
      queue: json['queue'] as int,
    );

Map<String, dynamic> _$CreateGadgetModelToJson(CreateGadgetModel instance) =>
    <String, dynamic>{
      'type': _$HomeGadgetTypeEnumMap[instance.type],
      'apiUrls': instance.apiUrls,
      'imageUrls': instance.imageUrls,
      'brandIds': instance.brandIds,
      'productIds': instance.productIds,
      'swiperBannersCount': instance.swiperBannersCount,
      'queue': instance.queue,
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
};
