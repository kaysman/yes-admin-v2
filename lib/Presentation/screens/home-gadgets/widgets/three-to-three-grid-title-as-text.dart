import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/gadget-review.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/image_preview.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ImageType {
  IMAGE_1,
  IMAGE_2,
  IMAGE_3,
  IMAGE_4,
  IMAGE_5,
  IMAGE_6,
  IMAGE_7,
  IMAGE_8,
  IMAGE_9,
}

class ThreeToThreeGridWithTitleAsText extends StatefulWidget {
  const ThreeToThreeGridWithTitleAsText({Key? key, required this.gadgetBloc})
      : super(key: key);
  final GadgetBloc gadgetBloc;
  @override
  State<ThreeToThreeGridWithTitleAsText> createState() =>
      _ThreeToThreeGridWithTitleAsTextState();
}

class _ThreeToThreeGridWithTitleAsTextState
    extends State<ThreeToThreeGridWithTitleAsText> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GadgetStatus? status;
  GadgetLocation? location;
  FilePickerResult? _selectedImage_1;
  FilePickerResult? _selectedImage_2;
  FilePickerResult? _selectedImage_3;
  FilePickerResult? _selectedImage_4;
  FilePickerResult? _selectedImage_5;
  FilePickerResult? _selectedImage_6;
  FilePickerResult? _selectedImage_7;
  FilePickerResult? _selectedImage_8;
  FilePickerResult? _selectedImage_9;
  TextEditingController imageLink1Controller = TextEditingController();
  TextEditingController imageLink2Controller = TextEditingController();
  TextEditingController imageLink3Controller = TextEditingController();
  TextEditingController imageLink4Controller = TextEditingController();
  TextEditingController imageLink5Controller = TextEditingController();
  TextEditingController imageLink6Controller = TextEditingController();
  TextEditingController imageLink7Controller = TextEditingController();
  TextEditingController imageLink8Controller = TextEditingController();
  TextEditingController imageLink9Controller = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Future<void> pickImage(ImageType type) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        if (type == ImageType.IMAGE_1) {
          _selectedImage_1 = result;
        } else if (type == ImageType.IMAGE_2) {
          _selectedImage_2 = result;
        } else if (type == ImageType.IMAGE_3) {
          _selectedImage_3 = result;
        } else if (type == ImageType.IMAGE_4) {
          _selectedImage_4 = result;
        } else if (type == ImageType.IMAGE_5) {
          _selectedImage_5 = result;
        } else if (type == ImageType.IMAGE_6) {
          _selectedImage_6 = result;
        } else if (type == ImageType.IMAGE_7) {
          _selectedImage_7 = result;
        } else if (type == ImageType.IMAGE_8) {
          _selectedImage_8 = result;
        } else if (type == ImageType.IMAGE_9) {
          _selectedImage_9 = result;
        }
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        if (_selectedImage_1 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_1),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_2 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_2),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_3 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_3),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_4 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_4),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_5 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_5),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_6 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_6),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_7 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_7),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_8 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_8),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage_9 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_9),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 14),
                    LabeledInput(
                      editMode: true,
                      controller: titleController,
                      hintText: 'Title text',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RowOfTwoChildren(
                      child1: InfoWithLabel<GadgetStatus>(
                        editMode: true,
                        hintText: 'Gadget status',
                        label: 'Status',
                        value: status,
                        onValueChanged: (v) {
                          setState(() {
                            status = v;
                          });
                        },
                        items: GadgetStatus.values
                            .map(
                              (e) => DropdownMenuItem<GadgetStatus>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                      ),
                      child2: InfoWithLabel<GadgetLocation>(
                        editMode: true,
                        hintText: 'Gadget status',
                        label: ' Location',
                        value: location,
                        onValueChanged: (v) {
                          setState(() {
                            location = v;
                          });
                        },
                        items: GadgetLocation.values
                            .map(
                              (e) => DropdownMenuItem<GadgetLocation>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildImageWithLink(
                              context,
                              _selectedImage_1,
                              ImageType.IMAGE_1,
                              imageLink1Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_2,
                              ImageType.IMAGE_2,
                              imageLink2Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_3,
                              ImageType.IMAGE_3,
                              imageLink3Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_4,
                              ImageType.IMAGE_4,
                              imageLink4Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_5,
                              ImageType.IMAGE_5,
                              imageLink4Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_6,
                              ImageType.IMAGE_6,
                              imageLink4Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_7,
                              ImageType.IMAGE_7,
                              imageLink4Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_8,
                              ImageType.IMAGE_8,
                              imageLink4Controller,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildImageWithLink(
                              context,
                              _selectedImage_9,
                              ImageType.IMAGE_9,
                              imageLink4Controller,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    BlocConsumer<GadgetBloc, GadgetState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return ButtonsForGadgetCreation(
                          formKey: _formKey,
                          isLoading:
                              state.createStatus == GadgetCreateStatus.loading,
                          onPressed: () async {
                            CreateGadgetModel model = CreateGadgetModel(
                              location: location,
                              status: status,
                              type: HomeGadgetType
                                  .TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT,
                              links: [
                                imageLink1Controller.text,
                                imageLink2Controller.text,
                                imageLink3Controller.text,
                                imageLink4Controller.text,
                                imageLink5Controller.text,
                                imageLink6Controller.text,
                                imageLink7Controller.text,
                                imageLink8Controller.text,
                                imageLink9Controller.text,
                              ],
                              queue: 1,
                              title: titleController.text,
                            );
                            if (_selectedImage_1 != null &&
                                _selectedImage_2 != null &&
                                _selectedImage_3 != null &&
                                _selectedImage_4 != null &&
                                _selectedImage_5 != null &&
                                _selectedImage_6 != null &&
                                _selectedImage_7 != null &&
                                _selectedImage_8 != null &&
                                _selectedImage_9 != null) {
                              await widget.gadgetBloc.createHomeGadget(
                                [
                                  _selectedImage_1!,
                                  _selectedImage_2!,
                                  _selectedImage_3!,
                                  _selectedImage_4!,
                                  _selectedImage_5!,
                                  _selectedImage_6!,
                                  _selectedImage_7!,
                                  _selectedImage_8!,
                                  _selectedImage_9!,
                                ],
                                model.toJson(),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: GadgetReview(
                description: 'Dummy text..',
                imgPath: '3-to-3-grid-title-as-text.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildImageWithLink(BuildContext context, FilePickerResult? selectedImage,
      ImageType type, TextEditingController imageLinkController) {
    return Row(
      children: [
        Expanded(
            child: ImageSelectCard(
          editMode: true,
          image: selectedImage,
          pickImage: () => this.pickImage(type),
        )),
        SizedBox(width: 14),
        Expanded(
          child: LabeledInput(
            editMode: true,
            controller: imageLinkController,
            hintText: 'Link',
          ),
        )
      ],
    );
  }
}
