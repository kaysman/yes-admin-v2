import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Data/models/category/update-category.model.dart';
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

class UpdateCategoryPage extends StatefulWidget {
  const UpdateCategoryPage({Key? key, required this.category})
      : super(key: key);

  final CategoryEntity category;
  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  late CategoryBloc categoryBloc;
  CategoryEntity? category;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  final descriptionController_tm = TextEditingController();
  final descriptionController_ru = TextEditingController();
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (categoryBloc.state.categories == null) {
      categoryBloc.getAllCategories();
    }
    titleController_tm.text = widget.category.title_tm ?? '';
    titleController_ru.text = widget.category.title_ru ?? '';
    descriptionController_tm.text = widget.category.description_tm ?? '';
    descriptionController_ru.text = widget.category.description_ru ?? '';
    category = widget.category;
  }

  String? get getOldTitileTm => widget.category.title_tm;
  String? get getOldTitileRu => widget.category.title_ru;
  String? get getOldDescriptionTm => widget.category.description_tm;
  String? get getOldDescriptionRu => widget.category.description_ru;
  int? get getOldParentId => widget.category.parentId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listenWhen: (s1, s2) =>
          s1.updateStatus != s2.updateStatus ||
          s1.deleteStatus != s2.deleteStatus,
      listener: (context, state) {
        if (state.updateStatus == CategoryUpdateStatus.success) {
          print(state.updateStatus);
          showSnackBar(context, Text('Updated successfully'),
              type: SnackbarType.success);
          Navigator.of(context).pop();
        }
        if (state.deleteStatus == CategoryDeleteStatus.success) {
          print(state.deleteStatus);
          showSnackBar(context, Text('Deleted successfully'),
              type: SnackbarType.success);
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
                    "Kategoriya uytget".toUpperCase(),
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
                    hintText: "Kategoriyanyn ady-tm *",
                    validator: emptyField,
                    editMode: editMode,
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    editMode: editMode,
                    controller: titleController_ru,
                    hintText: "Kategoriyanyn ady-ru",
                  ),
                  SizedBox(height: 14),
                  InfoWithLabel<CategoryEntity>(
                    label: 'Easy kategoriya',
                    editMode: true,
                    validator: notSelectedItem,
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
                    editMode: editMode,
                    controller: descriptionController_tm,
                    hintText: "Barada-tm",
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: descriptionController_ru,
                    hintText: "Barada-ru",
                    editMode: editMode,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Delete',
                        textColor: Colors.redAccent,
                        borderColor: Colors.redAccent,
                        hasBorder: true,
                        isLoading:
                            state.deleteStatus == CategoryDeleteStatus.loading,
                        onPressed: () {
                          if (widget.category.id != null) {
                            categoryBloc.deleteCategory(widget.category.id!);
                          }
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        text: "Update",
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        isLoading:
                            state.updateStatus == CategoryUpdateStatus.loading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            UpdateCategoryDTO data = UpdateCategoryDTO(
                                id: widget.category.id,
                                description_tm: checkIfChangedAndReturn(
                                    getOldDescriptionTm,
                                    descriptionController_ru.text),
                                title_tm: checkIfChangedAndReturn(
                                    getOldTitileTm, titleController_tm.text),
                                title_ru: checkIfChangedAndReturn(
                                    getOldTitileRu, titleController_ru.text),
                                description_ru: checkIfChangedAndReturn(
                                    getOldDescriptionRu,
                                    descriptionController_tm.text),
                                parentId: checkIfChangedAndReturn(
                                  getOldParentId,
                                  category?.id,
                                ));

                            await categoryBloc.updateCategory(data);
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
      },
    );
  }
}
