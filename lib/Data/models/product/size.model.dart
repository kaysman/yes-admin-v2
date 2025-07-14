import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'size.model.g.dart';

@JsonSerializable()
class SizeEntity with EquatableMixin {
  final int? id;
  int? quantity;
  final int? product_id;
  final String? name_ru;
  final String? name_tm;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  SizeEntity({
    this.name_ru,
    this.id,
    this.name_tm,
    this.quantity,
    this.product_id,
    this.updatedAt,
    this.createdAt,
  });

  factory SizeEntity.fromJson(Map<String, dynamic> json) =>
      _$SizeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SizeEntityToJson(this);

  @override
  List<Object?> get props => [this.id];
}
