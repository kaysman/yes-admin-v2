import 'filter.enum.dart';

class CreateFilterDTO {
  final String name_tm;
  final String name_ru;
  final FilterType type;

  CreateFilterDTO({
    required this.name_tm,
    required this.name_ru,
    required this.type,
  });
}
