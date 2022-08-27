import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../example/widgets/fluent-labeled-input.dart';
import 'bloc/filter.bloc.dart';

class CreateFilterPage extends StatefulWidget {
  const CreateFilterPage({Key? key}) : super(key: key);

  @override
  State<CreateFilterPage> createState() => _CreateFilterPageState();
}

class _CreateFilterPageState extends State<CreateFilterPage> {
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
                    style:
                        FluentTheme.of(context).typography.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(height: 20),
                  FluentLabeledInput(
                    controller: titleController_tm,
                    isEditMode: true,
                    isTapped: false,
                    label: "Filterin ady-tm *",
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isEditMode: true,
                    isTapped: false,
                    label: "Filterin ady-ru",
                    controller: titleController_ru,
                  ),
                  SizedBox(height: 14),
                  CustomAutoSuggestedBox(
                    items: FilterType.values.map((e) => e.name).toList(),
                    onChanged: (v) {
                      if (v != null) {
                        var types = FilterType.values.where((el) =>
                            v.toLowerCase().contains(el.name.toLowerCase()));
                        setState(() {
                          selectedType = types.first;
                        });
                      }
                    },
                    label: 'Filter gornusleri',
                    isEditMode: true,
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
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        isLoading:
                            state.createStatus == FilterCreateStatus.loading,
                        onPressed: () async {
                          if (true) {
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
