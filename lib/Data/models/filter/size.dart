import 'package:json_annotation/json_annotation.dart';
part 'size.g.dart';

@JsonSerializable()
class CreateSizeDTO {
  final int size;
  final int count;

  CreateSizeDTO({
    required this.size,
    required this.count,
  });

  factory CreateSizeDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateSizeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSizeDTOToJson(this);
}
