import 'dart:convert';

import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:json_annotation/json_annotation.dart';
part 'create-gadget.model.g.dart';

@JsonSerializable()
class CreateGadgetModel {
  final HomeGadgetType? type;
  final List<String>? links;
  final List<String>? productIds;
  final int? queue;
  final String? title;
  final GadgetStatus? status;
  final GadgetLocation? location;

  CreateGadgetModel({
    this.links,
    this.status,
    this.location,
    this.type,
    this.productIds,
    this.queue,
    this.title,
  });

  factory CreateGadgetModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGadgetModelFromJson(json);

  Map<String, String> toJson() => <String, String>{
        'type': _$HomeGadgetTypeEnumMap[this.type].toString(),
        'links': json.encode(this.links),
        'productIds': json.encode(this.productIds),
        'queue': this.queue.toString(),
        'title': this.title.toString(),
        'status': _$GadgetStatusEnumMap[this.status].toString(),
        'location': _$GadgetLocationEnumMap[this.location].toString()
      };

  // factory CreateGadgetModel.fromJson(Map<String, dynamic> json) =>
  //     CreateGadgetModel(
  //       type: $enumDecode(_$HomeGadgetTypeEnumMap, json['type']),
  //       apiUrls:
  //           (json['apiUrls'] as List<dynamic>).map((e) => e as String).toList(),
  //       brandIds: (json['brandIds'] as List<dynamic>?)
  //           ?.map((e) => e as String)
  //           .toList(),
  //       productIds: (json['productIds'] as List<dynamic>?)
  //           ?.map((e) => e as String)
  //           .toList(),
  //       swiperBannersCount: json['swiperBannersCount'] as int?,
  //       queue: json['queue'] as int,
  //     );

  // Map<String, String> toJson() {
  //   Map<String, String> data = <String, String>{'queue': queue.toString()};

  //   if (_$HomeGadgetTypeEnumMap[this.type] != null) {
  //     data['type'] = _$HomeGadgetTypeEnumMap[this.type]!;
  //   }

  //   if (this.links != null) {
  //     data['links'] = json.encode(this.links);
  //   }

  //   // if (this.brandIds != null) {
  //   //   data['brandIds'] = json.encode(this.brandIds);
  //   // }

  //   if (this.productIds != null) {
  //     data['productIds'] = json.encode(this.productIds);
  //   }

  //   if (this.title != null) {
  //     data['title'] = this.title!;
  //   }

  //   return data;
  // }
}

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
