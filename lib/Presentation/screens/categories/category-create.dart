import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({Key? key}) : super(key: key);

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  final descriptionController_tm = TextEditingController();
  final descriptionController_ru = TextEditingController();

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
                  BlocConsumer(
                      listener: (_, state) {},
                      builder: (context, state) {
                        return Button(
                          text: "Save",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              CreateCategoryDTO data = CreateCategoryDTO(
                                title_tm: titleController_tm.text,
                                title_ru: titleController_ru.text,
                                description_ru: descriptionController_tm.text,
                                description_tm: descriptionController_ru.text,
                              );
                              context.read<CategoryBloc>().createCategory(data);
                            }
                          },
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
