import 'package:json_annotation/json_annotation.dart';
part 'link.model.g.dart';

@JsonSerializable()
class GadgetLink {
  final int? gadgetId;
  final String? link;

  GadgetLink({
    this.gadgetId,
    this.link,
  });

  factory GadgetLink.fromJson(Map<String, dynamic> json) =>
      _$GadgetLinkFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetLinkToJson(this);
}
