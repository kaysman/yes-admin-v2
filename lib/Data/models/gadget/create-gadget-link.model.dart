import 'package:json_annotation/json_annotation.dart';

import 'create-gadget-subcategory.model.dart';
part 'create-gadget-link.model.g.dart';

@JsonSerializable()
class CreateGadgetLink {
  final String link;


  CreateGadgetLink({
    required this.link,

  });

  factory CreateGadgetLink.fromJson(Map<String, dynamic> json) =>
      _$CreateGadgetLinkFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGadgetLinkToJson(this);

  @override
  String toString() => '$link';
}
