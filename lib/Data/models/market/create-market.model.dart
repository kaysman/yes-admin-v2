import 'package:json_annotation/json_annotation.dart';
part 'create-market.model.g.dart';

@JsonSerializable()
class CreateMarketDTO {
  final String title;
  final String? address;
  final String? description;
  final String phoneNumber;
  final String? ownerName;

  CreateMarketDTO({
    required this.title,
    this.address,
    this.description,
    required this.phoneNumber,
    this.ownerName,
  });

  factory CreateMarketDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateMarketDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMarketDTOToJson(this);
}
