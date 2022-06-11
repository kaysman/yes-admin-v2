import 'package:admin_v2/Data/models/filter/size.dart';

class CreateProductDTO {
  final String? name_tm;
  final String? name_ru;
  final String? price;
  final int? color_id;
  final int? gender_id;
  final int? brand_id;
  final int? category_id;
  final int? market_id;
  final int? code;
  final int? description_tm;
  final int? description_ru;
  final List<CreateSizeDTO>? sizes;

  CreateProductDTO({
    this.name_tm,
    this.name_ru,
    this.price,
    this.color_id,
    this.gender_id,
    this.brand_id,
    this.category_id,
    this.market_id,
    this.code,
    this.description_tm,
    this.description_ru,
    this.sizes,
  });
}
