import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'size.g.dart';

@JsonSerializable()
class CreateSizeDTO with EquatableMixin {
  final int? size_id;
  final int? count;

  CreateSizeDTO({
    required this.size_id,
    this.count = 1,
  });

  factory CreateSizeDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateSizeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSizeDTOToJson(this);

  @override
  String toString() => 'SIZE : $size_id  $count';

  @override
  List<Object?> get props => [this.size_id];
}
