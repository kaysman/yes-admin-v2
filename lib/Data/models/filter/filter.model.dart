import 'filter.enum.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter.model.g.dart';

@JsonSerializable()
class FilterDTO {
  final String name_tm;
  final String name_ru;
  final FilterType type;

  FilterDTO({
    required this.name_tm,
    required this.name_ru,
    required this.type,
  });

  factory FilterDTO.fromJson(Map<String, dynamic> json) =>
      _$FilterDTOFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDTOToJson(this);
}
