import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CreateMarketPage extends StatefulWidget {
  const CreateMarketPage({Key? key}) : super(key: key);

  @override
  State<CreateMarketPage> createState() => _CreateMarketPageState();
}

class _CreateMarketPageState extends State<CreateMarketPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  FilterType? selectedType;

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
                "Filter döret".toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController_tm,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Kategoriyanyn ady-tm *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: titleController_ru,
                decoration: InputDecoration(
                  labelText: "Kategoriyanyn ady-ru ",
                ),
              ),
              SizedBox(height: 14),
              DropdownButtonFormField2<FilterType>(
                validator: emptyField,
                value: selectedType,
                onChanged: (val) {
                  selectedType = val;
                },
                items: FilterType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
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
                        FilterDTO data = FilterDTO(
                          name_tm: titleController_tm.text,
                          name_ru: titleController_ru.text,
                          type: selectedType!,
                        );
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
