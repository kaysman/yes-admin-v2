import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../services/api_client.dart';
part 'brand.model.g.dart';

@JsonSerializable()
class BrandEntity extends Equatable {
  final int id;
  final String? name;
  final String? logo;
  final bool? vip;
  final List<ProductEntity>? products;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  bool isSelected;

  BrandEntity(
      {this.isSelected = false,
      required this.id,
      this.name,
      this.logo,
      this.vip,
      this.createdAt,
      this.updatedAt,
      this.products});

  String? get fullPathLogo => logo == null ? null : baseUrl + '/' + logo!;

  factory BrandEntity.fromJson(Map<String, dynamic> json) =>
      _$BrandEntityFromJson(json);

  Map<String, String> toJson() => <String, String>{
        'id': this.id.toString(),
        'name': this.name.toString(),
        'vip': this.vip.toString(),
      };

  @override
  List<Object?> get props => [id];
}
