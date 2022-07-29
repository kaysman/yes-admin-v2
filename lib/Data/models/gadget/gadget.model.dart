import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/image.model.dart';
import 'package:admin_v2/Data/models/gadget/link.model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gadget.model.g.dart';

@JsonSerializable()
class GadgetEntity with EquatableMixin {
  final int? id;
  final String? type;
  final List<GadgetLink>? links;
  final List<GadgetImage>? items;
  final List<int>? productIds;
  final int? queue;
  final String? title;
  final String? status;
  final String? location;

  GadgetEntity({
    this.items,
    this.links,
    this.status,
    this.location,
    this.type,
    this.productIds,
    this.queue,
    this.title,
    this.id,
  });

  factory GadgetEntity.fromJson(Map<String, dynamic> json) =>
      _$GadgetEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetEntityToJson(this);

  @override
  List<Object?> get props => [this.id];

  @override
  String toString() => 'Gadget $id $type';
}
