import 'filter.enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter.entity.model.g.dart';

@JsonSerializable()
class FilterEntity {
  final int id;
  final String name_tm;
  final String name_ru;
  final FilterType type;
  bool isSelected;

  FilterEntity({
    this.isSelected = false,
    required this.id,
    required this.name_tm,
    required this.name_ru,
    required this.type,
  });

  factory FilterEntity.fromJson(Map<String, dynamic> json) =>
      _$FilterEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FilterEntityToJson(this);
}
