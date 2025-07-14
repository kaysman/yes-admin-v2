import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateFilterPage extends StatefulWidget {
  const UpdateFilterPage({Key? key, required this.filter}) : super(key: key);

  final FilterEntity filter;

  @override
  State<UpdateFilterPage> createState() => _UpdateFilterPageState();
}

class _UpdateFilterPageState extends State<UpdateFilterPage> {
  late FilterBloc filterBloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  FilterType? selectedType;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    titleController_tm.text = widget.filter.name_tm ?? '';
    titleController_ru.text = widget.filter.name_ru ?? '';
    selectedType = widget.filter.type;

    filterBloc = BlocProvider.of<FilterBloc>(context);
  }

  String? get getOldTitleTm => widget.filter.name_tm;
  String? get getOldTitleRu => widget.filter.name_ru;
  FilterType? get getOldType => widget.filter.type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Filter döret".toUpperCase(),
              style: FluentTheme.of(context).typography.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
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
              isEditMode: editMode,
              isTapped: false,
              label: "Filterin ady-tm *",
            ),
            SizedBox(height: 14),
            FluentLabeledInput(
              isEditMode: editMode,
              isTapped: false,
              label: "Filterin ady-ru",
              controller: titleController_ru,
            ),
            SizedBox(height: 14),
            CustomAutoSuggestedBox(
              items: FilterType.values.map((e) => e.name).toList(),
              onChanged: (v) {
                if (v != null) {
                  var types = FilterType.values.where(
                      (el) => v.toLowerCase().contains(el.name.toLowerCase()));
                  setState(() {
                    selectedType = types.first;
                  });
                }
              },
              label: 'Filter gornusleri',
              isEditMode: editMode,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                f.Button(
                  text: "Update",
                  primary: kswPrimaryColor,
                  textColor: kWhite,
                  onPressed: () async {
                    if (true) {
                      FilterEntity data = FilterEntity(
                        id: widget.filter.id,
                        name_tm: titleController_tm.text,
                        name_ru: titleController_ru.text,
                        type: selectedType!,
                      );
                      // await filterBloc.updateFilter(data);
                      Navigator.of(context).pop(data);
                    }
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
