import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Data/models/product/create-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../filters/bloc/filter.state.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({Key? key, required this.product}) : super(key: key);

  final ProductEntity product;
  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
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
  bool editMode = false;

  @override
  void initState() {
    super.initState();

    titleController_tm.text = widget.product.name_tm;
    titleController_ru.text = widget.product.name_tm;
    priceController.text = widget.product.price;
    quantityController.text = widget.product.quantity as String;
    codeController.text = widget.product.code as String;
    descriptionController_tm.text = widget.product.description_tm ?? '';
    descriptionController_ru.text = widget.product.description_ru ?? '';
  }

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
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => setState(() => editMode = !editMode),
                child: Text(
                  editMode ? "Cancel" : "Üýtget",
                ),
              ),
              SizedBox(height: 20),
              LabeledInput(
                controller: titleController_tm,
                label: "Harydyň ady-tm *",
                validator: emptyField,
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController_ru,
                label: "Harydyň ady-ru *",
                validator: emptyField,
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController_ru,
                label: "Bahasy *",
                validator: emptyField,
                editMode: editMode,
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
                  onChanged: editMode
                      ? (val) {
                          size = val;
                          sizes!.add(val!);
                        }
                      : null,
                  items: sizes?.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name_tm),
                    );
                  }).toList(),
                ),
              ),
              // SizedBox(height: 14),
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
              LabeledInput(
                controller: titleController_ru,
                label: "Kody *",
                validator: emptyField,
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController_ru,
                label: "Barada-tm",
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController_ru,
                label: "Barada-ru",
                editMode: editMode,
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
                  BlocConsumer<FilterBloc, FilterState>(
                    listener: (context, state) {
                      if (state.createStatus == MarketCreateStatus.success) {
                        Navigator.of(context).pop();
                      }
                    },
                    builder: (context, state) {
                      return Button(
                        text: "Save",
                        isLoading:
                            state.createStatus == MarketCreateStatus.loading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            String? logo64String;
                            if (_selectedLogoImage != null) {
                              logo64String =
                                  '${base64.encode(_selectedLogoImage!.files[0].bytes as List<int>)}-ext-${_selectedLogoImage!.files[0].extension}';
                              ;
                            }

                            CreateProductDTO data = CreateProductDTO();
                          }
                        },
                      );
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
