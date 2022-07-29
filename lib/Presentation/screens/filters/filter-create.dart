import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
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

import 'bloc/filter.bloc.dart';

class CreateFliterPage extends StatefulWidget {
  const CreateFliterPage({Key? key}) : super(key: key);

  @override
  State<CreateFliterPage> createState() => _CreateFliterPageState();
}

class _CreateFliterPageState extends State<CreateFliterPage> {
  late FilterBloc filterBloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  FilterType? selectedType;

  @override
  void initState() {
    super.initState();

    filterBloc = BlocProvider.of<FilterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterBloc, FilterState>(
      listenWhen: (s1, s2) => s1.createStatus != s2.createStatus,
      listener: (context, state) {
        if (state.createStatus == FilterCreateStatus.success) {
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
                  LabeledInput(
                    controller: titleController_tm,
                    validator: emptyField,
                    hintText: "Filterin ady-tm *",
                    editMode: true,
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    editMode: true,
                    controller: titleController_ru,
                    hintText: "Filterin ady-ru ",
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
                      Button(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        text: "Save",
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        isLoading:
                            state.createStatus == FilterCreateStatus.loading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            FilterDTO data = FilterDTO(
                              name_tm: titleController_tm.text,
                              name_ru: titleController_ru.text,
                              type: selectedType!,
                            );
                            await filterBloc.createFilter(data);
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
