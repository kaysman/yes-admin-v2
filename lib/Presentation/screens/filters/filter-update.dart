import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFilterPage extends StatefulWidget {
  const CreateFilterPage({Key? key, required this.filter}) : super(key: key);

  final FilterEntity filter;

  @override
  State<CreateFilterPage> createState() => _CreateFilterPageState();
}

class _CreateFilterPageState extends State<CreateFilterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  FilterType? selectedType;
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    titleController_tm.text = widget.filter.name_tm;
    titleController_ru.text = widget.filter.name_ru;
    selectedType = widget.filter.type;
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
                label: "Filterin ady-tm *",
                editMode: editMode,
                validator: emptyField,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController_ru,
                label: "Filterin ady-ru",
                editMode: editMode,
              ),
              SizedBox(height: 14),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField2<FilterType>(
                  isExpanded: true,
                  validator: emptyField,
                  value: selectedType,
                  onChanged: editMode
                      ? (val) {
                          selectedType = val;
                        }
                      : null,
                  items: FilterType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name),
                    );
                  }).toList(),
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
                  BlocConsumer<FilterBloc, FilterState>(
                      listener: (_, state) {},
                      builder: (context, state) {
                        return Button(
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
