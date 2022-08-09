import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class GadgetLink {
  TextEditingController controller;
  FilePickerResult? image;
  CategoryEntity? category;
  ProductEntity? product;

  GadgetLink({
    required this.controller,
    this.image,
    this.category,
    this.product,
  });

  Map<String, String> toJson() {
    Map<String, String> data = <String, String>{};
    data['link'] = controller.text;
    return data;
  }

  @override
  String toString() => '${controller.text} image: ${image?.names.first}';
}
