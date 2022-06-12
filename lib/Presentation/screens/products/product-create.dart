import 'dart:convert';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Data/models/product/create-product.model.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final codeController = TextEditingController();
  final descriptionController_tm = TextEditingController();
  final descriptionController_ru = TextEditingController();
  FilterDTO? color;
  List<FilterDTO>? colors;
  FilterDTO? gender;
  List<FilterDTO>? genders;
  FilterDTO? size;
  List<FilterDTO>? sizes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Haryt döret".toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController_tm,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Harydyň ady-tm *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: titleController_ru,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Harydyň ady-ru *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: priceController,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Bahasy *",
                ),
              ),
              // TODO: SELECT COLOR
              // DropdownButtonHideUnderline(
              //   child: DropdownButtonFormField2<FilterDTO>(
              //     isExpanded: true,
              //     hint: Text('Select color', style: Theme.of(context).textTheme.subtitle1!.copyWith(color:   Colors.black54 ),),
              //     validator: emptyField,
              //     value: color,
              //     onChanged: (val) {
              //       color = val;
              //     },
              //     items: .map((type) {
              //       return DropdownMenuItem(
              //         value: type,
              //         child: Text(type.name),
              //       );
              //     }).toList(),
              //   ),
              // ),

              SizedBox(height: 14),
              // TODO: SELECT SIZES
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField2<FilterDTO>(
                  isExpanded: true,
                  hint: Text(
                    'Select sizes',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.black54),
                  ),
                  validator: emptyField,
                  value: size,
                  onChanged: (val) {
                    size = val;
                    sizes!.add(val!);
                  },
                  items: sizes!.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name_tm),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 14),
              // TODO: SELECT CATEGORY
              // DropdownButtonHideUnderline(
              //   child: DropdownButtonFormField2<Category>(
              //     isExpanded:true ,
              //     hint: Text(
              //       'Select caategory',
              //       style: Theme.of(context)
              //           .textTheme
              //           .subtitle1!
              //           .copyWith(color: Colors.black54),
              //     ),
              //     validator: emptyField,
              //     value: category,
              //     onChanged: (val) {
              //       category = val;
              //     },
              //     items: categories!.map((type) {
              //       return DropdownMenuItem(
              //         value: type,
              //         child: Text(type.name_tm),
              //       );
              //     }).toList(),
              //   ),
              // ),


              SizedBox(height: 14),
              TextFormField(
                controller: codeController,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Kody *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: descriptionController_tm,
                decoration: InputDecoration(
                  labelText: "Barada-tm",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: descriptionController_ru,
                decoration: InputDecoration(
                  labelText: "Barada-ru",
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Button(
                    text: "Save",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // CreateProductDTO data = CreateProductDTO(
                        //  brand_id: ,
                        //  category_id: ,
                        //  code: ,
                        //  color_id: ,
                        //  gender_id: ,
                        //  market_id: ,
                        //  name_ru: ,
                        //  name_tm: ,
                        //  price: ,
                        //  quantity: ,
                        //  description_ru: ,
                        //  description_tm: ,
                        //  sizes: ,
                        // );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
