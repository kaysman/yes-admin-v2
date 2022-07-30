import 'dart:convert';

import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-link.model.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-product.model.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-subcategory.model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CreateGadgetModel {
  final GadgetType? type;
  final List<CreateGadgetLink> links;
  final List<CreateGadgetSubCategory>? categories;
  final List<CreateGadgetProducts>? productIds;
  final int? queue;
  final String? title;
  final GadgetStatus? status;
  final GadgetLocation? location;

  CreateGadgetModel({
    this.categories,
    required this.links,
    this.status,
    this.location,
    this.type,
    this.productIds,
    this.queue,
    this.title,
  });

  // factory CreateGadgetModel.fromJson(Map<String, dynamic> json) =>
  //     _$CreateGadgetModelFromJson(json);

  Map<String, String> toJson() => <String, String>{
        'type': _$GadgetTypeEnumMap[this.type].toString(),
        'links': json.encode(this.links.map((e) => e.toJson()).toList()),
        'productIds': json.encode(this.productIds),
        'queue': this.queue.toString(),
        'title': this.title.toString(),
        'status': _$GadgetStatusEnumMap[this.status].toString(),
        'location': _$GadgetLocationEnumMap[this.location].toString()
      };

  // factory CreateGadgetModel.fromJson(Map<String, dynamic> json) =>
  //     CreateGadgetModel(
  //       type: $enumDecode(_$GadgetTypeEnumMap, json['type']),
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

  //   if (_$GadgetTypeEnumMap[this.type] != null) {
  //     data['type'] = _$GadgetTypeEnumMap[this.type]!;
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
const _$GadgetTypeEnumMap = {
  GadgetType.TWO_SMALL_CARDS_HORIZONTAL: 'TWO_SMALL_CARDS_HORIZONTAL',
  GadgetType.BANNER_SWIPE_WITH_DOTS: 'BANNER_SWIPE_WITH_DOTS',
  GadgetType.TWO_TO_TWO_WITH_TITLE_AS_IMAGE: 'TWO_TO_TWO_WITH_TITLE_AS_IMAGE',
  GadgetType.BANNER_FOR_MEN_AND_WOMEN: 'BANNER_FOR_MEN_AND_WOMEN',
  GadgetType.TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT:
      'TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT',
  GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:
      'CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT',
  GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE:
      'CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE',
  GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE:
      'CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE',
  GadgetType.THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT:
      'THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT',
  GadgetType.ONE_IMAGE_WITH_FULL_WIDTH: 'ONE_IMAGE_WITH_FULL_WIDTH',
  GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:
      'CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT',
  GadgetType.POPULAR: 'POPULAR',
  GadgetType.TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT:
      'TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT',
  GadgetType.CIRCLE_ITEMS: 'CIRCLE_ITEMS',
};
