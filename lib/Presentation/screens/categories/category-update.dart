import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/update-category.model.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';
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
  bool isUpdate = false;

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
                style: FluentTheme.of(context).typography.body,
              ),
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => setState(() => editMode = !editMode),
                child: Text(
                  editMode ? "Cancel" : "Üýtget",
                ),
              ),
              SizedBox(height: 20),
              FluentLabeledInput(
                controller: titleController_tm,
                label: "Kategoriyanyn ady-tm *",
                isTapped: isUpdate, // !
                isEditMode: editMode,
              ),
              SizedBox(height: 14),
              FluentLabeledInput(
                isEditMode: editMode,
                isTapped: false,
                controller: titleController_ru,
                label: "Kategoriyanyn ady-ru",
              ),
              SizedBox(height: 14),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  var categories = state.categories;
                  return CustomAutoSuggestedBox(
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
                    isEditMode: editMode,
                  );
                },
              ),
              SizedBox(height: 14),
              FluentLabeledInput(
                isEditMode: editMode,
                controller: descriptionController_tm,
                label: "Barada-tm",
                isTapped: false,
              ),
              SizedBox(height: 14),
              FluentLabeledInput(
                controller: descriptionController_ru,
                label: "Barada-ru",
                isEditMode: editMode,
                isTapped: false,
              ),
              SizedBox(height: 24),
              f.Button(
                text: "Update",
                primary: kswPrimaryColor,
                textColor: kWhite,
                onPressed: () {
                  setState(() {
                    isUpdate = true;
                  });
                  UpdateCategoryDTO data = UpdateCategoryDTO(
                    id: widget.category.id,
                    description_tm: checkIfChangedAndReturn(
                        getOldDescriptionTm, descriptionController_ru.text),
                    title_tm: checkIfChangedAndReturn(
                        getOldTitileTm, titleController_tm.text),
                    title_ru: checkIfChangedAndReturn(
                        getOldTitileRu, titleController_ru.text),
                    description_ru: checkIfChangedAndReturn(
                        getOldDescriptionRu, descriptionController_tm.text),
                    parentId: checkIfChangedAndReturn(
                      getOldParentId,
                      category?.id,
                    ),
                  );
                  Navigator.of(context).pop(data);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
