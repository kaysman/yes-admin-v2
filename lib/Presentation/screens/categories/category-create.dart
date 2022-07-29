import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({Key? key}) : super(key: key);

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  late CategoryBloc categoryBloc;
  CategoryEntity? category;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  final descriptionController_tm = TextEditingController();
  final descriptionController_ru = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (categoryBloc.state.categories == null) {
      categoryBloc.getAllCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listenWhen: (s1, s2) => s1.createStatus != s2.createStatus,
      listener: (context, state) {
        if (state.createStatus == CategoryCreateStatus.success) {
          showSnackBar(
            context,
            Text(
              'Created Successully',
            ),
            type: SnackbarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var categories = state.categories;
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
                    validator: emptyField,
                    editMode: true,
                    hintText: "Kategoriyanyn ady-tm *",
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: titleController_ru,
                    editMode: true,
                    hintText: "Kategoriyanyn ady-ru ",
                  ),
                  SizedBox(height: 14),
                  InfoWithLabel<CategoryEntity>(
                    label: 'Easy kategoriya',
                    editMode: true,
                    hintText: 'Select caategory *',
                    value: category,
                    onValueChanged: (v) {
                      setState(() {
                        category = v;
                      });
                    },
                    items: categories?.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.title_tm ?? ''),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: descriptionController_tm,
                    editMode: true,
                    hintText: "Barada-tm",
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: descriptionController_ru,
                    editMode: true,
                    hintText: "Barada-ru",
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        text: "Save",
                        textColor: kWhite,
                        primary: kswPrimaryColor,
                        isLoading:
                            state.createStatus == CategoryCreateStatus.loading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            CreateCategoryDTO data = CreateCategoryDTO(
                              title_tm: titleController_tm.text,
                              title_ru: titleController_ru.text,
                              description_ru: descriptionController_tm.text,
                              description_tm: descriptionController_ru.text,
                              parentId: category?.id,
                            );
                            await categoryBloc.createCategory(data);
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
