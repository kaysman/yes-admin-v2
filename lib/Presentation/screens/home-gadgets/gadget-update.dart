import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Data/models/gadget/update-gadget.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as fl;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/generated/l10n.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateGadGetPage extends StatefulWidget {
  const UpdateGadGetPage({Key? key, required this.gadget}) : super(key: key);

  final GadgetEntity gadget;
  @override
  State<UpdateGadGetPage> createState() => _UpdateGadGetPageState();
}

class _UpdateGadGetPageState extends State<UpdateGadGetPage> {
  late GadgetBloc gadgetBloc;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? type;
  String? location;
  String? status;
  final titleController = TextEditingController();
  final queueController = TextEditingController();
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    titleController.text = widget.gadget.title ?? '';
    queueController.text = widget.gadget.queue.toString();
  }

  String? get getOldTitle => widget.gadget.title;
  String? get getOldType => widget.gadget.type;
  int? get getOldQueue => widget.gadget.queue;
  String? get getOldStatus => widget.gadget.status;
  String? get oldGadgetType => widget.gadget.type;
  String? get getOldLocation => widget.gadget.location;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GadgetBloc, GadgetState>(
      listenWhen: (s1, s2) =>
          s1.updatedStatus != s2.updatedStatus ||
          s1.deleteStatus != s2.deleteStatus,
      listener: (context, state) {
        if (state.updatedStatusForShow == GadgetForUpdatedStatus.success) {
          log('Oh noo UPDATE');
          log(state.deleteStatus);
          log(state.updatedStatus);
          Navigator.of(context).pop();
          showSnackbar(
            context,
            Snackbar(
              content: Text('Updated successfully'),
            ),
          );
        } else if (state.deletedStatusForShow ==
            GadgetForDeletedStatus.success) {
          log('Oh noo DELETE');
          Navigator.of(context).pop();
          showSnackbar(
            context,
            Snackbar(
              content: Text('Deleted successfully'),
            ),
          );
        }
        ;
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
                    "Gadget uytget".toUpperCase(),
                    style: FluentTheme.of(context).typography.subtitle,
                  ),
                  SizedBox(height: 12),
                  Button(
                    onPressed: () => setState(() => editMode = !editMode),
                    child: Text(
                      editMode ? "Cancel" : "Üýtget",
                    ),
                  ),
                  SizedBox(height: 20),
                  FluentLabeledInput(
                    controller: titleController,
                    label: "Gadgetin ady",
                    isEditMode: editMode,
                    isTapped: false,
                  ),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    isEditMode: editMode,
                    controller: queueController,
                    label: "Gadgetin tertibi",
                    isTapped: false,
                  ),
                  SizedBox(height: 14),
                  CustomAutoSuggestedBox(
                    items: GadgetStatus.values.map((e) => e.name).toList(),
                    onChanged: (v) {
                      setState(() {
                        status = v;
                      });
                    },
                    label: 'Status',
                    initialValue: getOldStatus,
                    isEditMode: editMode,
                  ),
                  SizedBox(height: 14),
                  CustomAutoSuggestedBox(
                    items: GadgetType.values.map((e) => e.name).toList(),
                    onChanged: (v) {
                      setState(() {
                        type = v;
                      });
                    },
                    label: 'Gadgetin gornusi',
                    initialValue: getOldType,
                    isEditMode: editMode,
                  ),
                  SizedBox(height: 14),
                  CustomAutoSuggestedBox(
                    items: GadgetLocation.values.map((e) => e.name).toList(),
                    onChanged: (v) {
                      setState(() {
                        location = v;
                      });
                    },
                    initialValue: getOldLocation,
                    label: 'Gadgetin yerlesyan yeri',
                    isEditMode: editMode,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      fl.Button(
                        text: 'Delete',
                        textColor: Colors.red,
                        borderColor: Colors.red,
                        hasBorder: true,
                        isLoading:
                            state.deleteStatus == GadgetDeleteStatus.loading,
                        onPressed: () {
                          if (widget.gadget.id != null) {
                            gadgetBloc.deleteGadget(
                              widget.gadget.id!,
                              location: getOldLocation,
                              status: getOldStatus,
                            );
                          }
                        },
                      ),
                      SizedBox(width: 16),
                      fl.Button(
                        text: "Update",
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        isLoading:
                            state.updatedStatus == GadgetUpdatedStatus.loading,
                        onPressed: () async {
                          UpdateGadgetModel data = UpdateGadgetModel(
                            id: widget.gadget.id,
                            location: checkIfChangedAndReturn(
                                getOldLocation, location),
                            status:
                                checkIfChangedAndReturn(getOldStatus, status),
                            queue: checkIfChangedAndReturn(getOldQueue,
                                int.tryParse(queueController.text)),
                            title: checkIfChangedAndReturn(
                                getOldTitle, titleController.text),
                            type: checkIfChangedAndReturn(getOldType, type),
                          );
                          await gadgetBloc.updateGadget(
                            data,
                            status: getOldStatus,
                            location: getOldLocation,
                          );
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
