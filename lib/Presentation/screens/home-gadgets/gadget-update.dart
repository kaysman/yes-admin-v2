import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Data/models/gadget/update-gadget.model.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
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
  HomeGadgetType? type;
  GadgetLocation? location;
  GadgetStatus? status;
  final titleController = TextEditingController();
  final queueController = TextEditingController();
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);

    titleController.text = widget.gadget.title ?? '';
    // type = widget.gadget.type;
    // queueController.text = widget.gadget.queue.toString();
    // status = widget.gadget.status;
    // location = widget.gadget.location;
  }

  String? get getOldTitile => widget.gadget.title;
  String? get getOldType => widget.gadget.type;
  int? get getOldQueue => widget.gadget.queue;
  String? get getOldStatus => widget.gadget.status;
  String? get getOldLocation => widget.gadget.location;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GadgetBloc, GadgetState>(
      listenWhen: (s1, s2) => true,
      listener: (context, state) {
        // if (state.updateStatus == CategoryUpdateStatus.success) {
        //   print(state.updateStatus);
        //   showSnackBar(context, Text('Updated successfully'),
        //       type: SnackbarType.success);
        //   Navigator.of(context).pop();
        // }
        // if (state.deleteStatus == CategoryDeleteStatus.success) {
        //   print(state.deleteStatus);
        //   showSnackBar(context, Text('Deleted successfully'),
        //       type: SnackbarType.success);
        //   Navigator.of(context).pop();
        // }
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
                    controller: titleController,
                    hintText: "Gadgetin ady",
                    editMode: editMode,
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    editMode: editMode,
                    controller: queueController,
                    hintText: "Gadgetin tertibi",
                  ),
                  SizedBox(height: 14),
                  InfoWithLabel<GadgetStatus>(
                    label: 'Status',
                    editMode: editMode,
                    hintText: 'Status',
                    value: status,
                    onValueChanged: (v) {
                      setState(() {
                        status = v;
                      });
                    },
                    items: GadgetStatus.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 14),
                  InfoWithLabel<GadgetLocation>(
                    label: 'Gadgetin yerlesyan yeri',
                    editMode: editMode,
                    hintText: 'GadGetin yerlesyan yeri',
                    value: location,
                    onValueChanged: (v) {
                      setState(() {
                        location = v;
                      });
                    },
                    items: GadgetLocation.values.map((type) {
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
                        text: 'Delete',
                        textColor: Colors.redAccent,
                        borderColor: Colors.redAccent,
                        hasBorder: true,
                        isLoading:
                            state.deleteStatus == GadgetDeleteStatus.loading,
                        onPressed: () {
                          if (widget.gadget.id != null) {
                            gadgetBloc.deleteGadget(widget.gadget.id!);
                          }
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        text: "Update",
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        isLoading:
                            state.updatedStatus == GadgetUpdatedStatus.loading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // UpdateGadgetModel data = UpdateGadgetModel(
                            //   id: widget.gadget.id,
                            //   location: checkIfChangedAndReturn(
                            //       getOldLocation, location),
                            //   status:
                            //       checkIfChangedAndReturn(getOldStatus, status),
                            //   queue: checkIfChangedAndReturn(getOldQueue,
                            //       int.tryParse(queueController.text)),
                            //   title: checkIfChangedAndReturn(
                            //       getOldTitile, titleController.text),
                            //   type: checkIfChangedAndReturn(getOldType, type),
                            // );
                            // await gadgetBloc.updateGadget(data);
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
