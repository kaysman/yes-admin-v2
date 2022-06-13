import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:flutter/material.dart';

class UpdateCategoryPage extends StatefulWidget {
  const UpdateCategoryPage({Key? key, required this.category})
      : super(key: key);

  final CategoryEntity category;
  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  final descriptionController_tm = TextEditingController();
  final descriptionController_ru = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController_tm.text = widget.category.title_tm;
    titleController_ru.text = widget.category.title_ru ?? '';
    descriptionController_tm.text = widget.category.description_tm ?? '';
    descriptionController_ru.text = widget.category.description_ru ?? '';
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
                "Kategoriya döret".toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 20),
              LabeledInput(
                controller: titleController_tm,
                label: "Kategoriyanyn ady-tm *",
                validator: emptyField,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController_ru,
                label: "Kategoriyanyn ady-ru ",
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: descriptionController_tm,
                label: "Barada-tm",
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: descriptionController_ru,
                label: "Barada-ru",
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
                        CreateCategoryDTO data = CreateCategoryDTO(
                          title_tm: titleController_tm.text,
                          title_ru: titleController_ru.text,
                          description_ru: descriptionController_tm.text,
                          description_tm: descriptionController_ru.text,
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
