import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/gadget-review.dart';
import 'package:admin_v2/Presentation/shared/components/image_preview.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/models/gadget/create-gadget.model.dart';

enum ImageType { IMAGE_1 }

class BannerForMenAndWomen extends StatefulWidget {
  const BannerForMenAndWomen({Key? key, required this.gadgetBloc})
      : super(key: key);
  final GadgetBloc gadgetBloc;
  @override
  State<BannerForMenAndWomen> createState() => _BannerForMenAndWomenState();
}

class _BannerForMenAndWomenState extends State<BannerForMenAndWomen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GadgetStatus? status;
  GadgetLocation? location;

  FilePickerResult? _selectedImage_1;
  TextEditingController imageLink1Controller = TextEditingController();
  TextEditingController imageLink2Controller = TextEditingController();

  Future<void> pickImage(ImageType type) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        if (type == ImageType.IMAGE_1) {
          _selectedImage_1 = result;
        }
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        ],
                      ),
                      SizedBox(height: 14),
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
                      buildLinks(context),
                      SizedBox(
                        height: 10,
                      ),
                      ImageSelectCard(
                        editMode: true,
                        image: _selectedImage_1,
                        pickImage: () => this.pickImage(ImageType.IMAGE_1),
                      ),
                      Spacer(),
                      BlocConsumer<GadgetBloc, GadgetState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return ButtonsForGadgetCreation(
                            formKey: _formKey,
                            isLoading: state.createStatus ==
                                GadgetCreateStatus.loading,
                            onPressed: () async {
                              CreateGadgetModel model = CreateGadgetModel(
                                // title: ,
                                status: status,
                                location: location,
                                type: HomeGadgetType.BANNER_FOR_MEN_AND_WOMEN,
                                links: [
                                  imageLink1Controller.text,
                                  imageLink2Controller.text,
                                ],
                                queue: 1,
                              );
                              if (_selectedImage_1 != null) {
                                await widget.gadgetBloc.createHomeGadget(
                                  [_selectedImage_1!],
                                  model.toJson(),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: GadgetReview(
                description: 'Description of Gadget...',
                imgPath: 'banner-for-men-and-women.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildLinks(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: LabeledInput(
          editMode: true,
          controller: imageLink1Controller,
          hintText: 'Image Link',
        )),
        SizedBox(width: 14),
        Expanded(
          child: LabeledInput(
            editMode: true,
            controller: imageLink2Controller,
            hintText: 'Image Link',
          ),
        )
      ],
    );
  }
}
