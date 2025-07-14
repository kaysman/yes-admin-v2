import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
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
  bool isCreate = false;

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
          Navigator.of(context).pop();
          showSnackbar(
            context,
            Snackbar(
              content: Text('Created successfully'),
            ),
          );
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
                    style: FluentTheme.of(context).typography.body,
                  ),
                  SizedBox(height: 20),
                  FluentLabeledInput(
                    controller: titleController_tm,
                    label: "Kategoriyanyn ady-tm *",
                    isTapped: isCreate, // !
                    isEditMode: true,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isEditMode: true,
                    isTapped: false,
                    controller: titleController_ru,
                    label: "Kategoriyanyn ady-ru",
                  ),
                  SizedBox(height: 14),
                  CustomAutoSuggestedBox(
                    items: categories?.map((e) => e.title_tm ?? '-').toList() ??
                        [],
                    onChanged: (v) {
                      var selectedItems = categories?.where(
                          (el) => v?.contains(el.title_tm ?? '-') == true);
                      if (selectedItems?.isNotEmpty == true) {
                        setState(
                          () {
                            category = selectedItems?.first;
                          },
                        );
                      }
                    },
                    label: 'Esasy kategoriya',
                    isEditMode: true,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isEditMode: true,
                    controller: descriptionController_tm,
                    label: "Barada-tm",
                    isTapped: false,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    controller: descriptionController_ru,
                    label: "Barada-ru",
                    isEditMode: true,
                    isTapped: false,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      f.Button(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      f.Button(
                        text: "Save",
                        textColor: kWhite,
                        primary: kswPrimaryColor,
                        isLoading:
                            state.createStatus == CategoryCreateStatus.loading,
                        onPressed: () async {
                          setState(() {
                            isCreate = true;
                          });
                          CreateCategoryDTO data = CreateCategoryDTO(
                            title_tm: titleController_tm.text,
                            title_ru: titleController_ru.text,
                            description_ru: descriptionController_tm.text,
                            description_tm: descriptionController_ru.text,
                            parentId: category?.id,
                          );
                          await categoryBloc.createCategory(data);
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
