import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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
    return BlocConsumer<FilterBloc, FilterState>(
      listenWhen: (state1, state2) =>
          state1.updateStatus != state2.updateStatus ||
          state1.deleteStatus != state2.deleteStatus,
      listener: (context, state) {
        if (state.updateStatus == FilterUpdateStatus.success) {
          showSnackBar(context, Text('Updated successfully'),
              type: SnackbarType.success);
          Navigator.of(context).pop();
        }
        if (state.deleteStatus == FilterDeleteStatus.success) {
          showSnackBar(context, Text('Deleted successfully'),
              type: SnackbarType.success);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Filter döret".toUpperCase(),
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
                  hintText: "Filterin ady-tm *",
                  editMode: editMode,
                  validator: emptyField,
                ),
                SizedBox(height: 14),
                LabeledInput(
                  controller: titleController_ru,
                  hintText: "Filterin ady-ru",
                  editMode: editMode,
                ),
                SizedBox(height: 14),
                InfoWithLabel<FilterType>(
                  label: 'Filter type',
                  editMode: true,
                  hintText: '',
                  value: selectedType,
                  onValueChanged: (val) {
                    setState(() {
                      selectedType = val;
                    });
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          text: 'Delete',
                          textColor: Colors.redAccent,
                          borderColor: Colors.redAccent,
                          hasBorder: true,
                          isLoading:
                              state.deleteStatus == FilterDeleteStatus.loading,
                          onPressed: () async {
                            if (widget.filter.id != null) {
                              await filterBloc.deleteFilter(widget.filter.id!);
                            }
                          },
                        ),
                        SizedBox(width: 16),
                        Button(
                          text: "Update",
                          primary: kswPrimaryColor,
                          textColor: kWhite,
                          isLoading:
                              state.updateStatus == FilterUpdateStatus.loading,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              FilterEntity data = FilterEntity(
                                id: widget.filter.id,
                                name_tm: titleController_tm.text,
                                name_ru: titleController_ru.text,
                                type: selectedType!,
                              );
                              await filterBloc.updateFilter(data);
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
