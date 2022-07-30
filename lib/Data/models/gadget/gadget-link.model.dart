import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:file_picker/file_picker.dart';

class GadgetLink {
  String link;
  FilePickerResult? image;
  CategoryEntity? category;
  ProductEntity? product;

  GadgetLink({
    required this.link,
    this.image,
    this.category,
    this.product,
  });

  Map<String, String> toJson() {
    Map<String, String> data = <String, String>{};
    data['link'] = link;
    return data;
  }
}
