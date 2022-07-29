import 'package:json_annotation/json_annotation.dart';
part 'pagination.model.g.dart';

@JsonSerializable()
class PaginationDTO {
  final int? lastId;
  final int? take;
  final String? search;

  PaginationDTO({
    this.lastId,
    this.take = 20,
    this.search,
  });

  factory PaginationDTO.fromJson(Map<String, dynamic> json) =>
      _$PaginationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDTOToJson(this);
}
