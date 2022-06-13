import 'package:admin_v2/Data/services/api_client.dart';
import 'package:json_annotation/json_annotation.dart';
part 'market.model.g.dart';

@JsonSerializable()
class MarketEntity {
  final int id;
  final String title;
  final String? logo;
  final String? address;
  final String? description;
  final String phoneNumber;
  final String? ownerName;
  bool isSelected;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  MarketEntity({
    this.isSelected = false,
    required this.id,
    required this.title,
    this.logo,
    this.address,
    this.description,
    required this.phoneNumber,
    this.ownerName,
    this.createdAt,
    this.updatedAt,
  });

  String? get fullPathImage => logo == null ? null : baseUrl + '/' + logo!;

  factory MarketEntity.fromJson(Map<String, dynamic> json) =>
      _$MarketEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MarketEntityToJson(this);
}
