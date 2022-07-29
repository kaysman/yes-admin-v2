// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationDTO _$PaginationDTOFromJson(Map<String, dynamic> json) =>
    PaginationDTO(
      lastId: json['lastId'] as int?,
      take: json['take'] as int? ?? 20,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$PaginationDTOToJson(PaginationDTO instance) =>
    <String, dynamic>{
      'lastId': instance.lastId,
      'take': instance.take,
      'search': instance.search,
    };
