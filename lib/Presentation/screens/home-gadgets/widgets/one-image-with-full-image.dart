import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/image_preview.dart';
import '../bloc/gadget.bloc.dart';

class OneImageWithFullWidth extends StatefulWidget {
  const OneImageWithFullWidth({Key? key, required this.gadgetBloc})
      : super(key: key);

  final GadgetBloc gadgetBloc;

  @override
  State<OneImageWithFullWidth> createState() => _OneImageWithFullWidthState();
}

class _OneImageWithFullWidthState extends State<OneImageWithFullWidth> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FilePickerResult? _selectedImage_1;
  TextEditingController imageLink1Controller = TextEditingController();

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        _selectedImage_1 = result;
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    buildImageWithLink(
                      context,
                      _selectedImage_1,
                      imageLink1Controller,
                    ),
                    Spacer(),
                    BlocConsumer<GadgetBloc, GadgetState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return ButtonsForGadgetCreation(
                          formKey: _formKey,
                          isLoading:
                              state.createStatus == GadgetCreateStatus.loading,
                          onPressed: () async {
                            CreateGadgetModel model = CreateGadgetModel(
                              type: HomeGadgetType.ONE_IMAGE_WITH_FULL_WIDTH,
                              apiUrls: [
                                imageLink1Controller.text,
                              ],
                              queue: 1,
                            );
                            if (_selectedImage_1 != null) {
                              await widget.gadgetBloc.createHomeGadget(
                                [
                                  _selectedImage_1!,
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
              )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: Card(
              child: Container(
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildImageWithLink(BuildContext context, FilePickerResult? selectedImage,
      TextEditingController imageLinkController) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black38,
                width: 0.0,
              ),
            ),
            child: ListTile(
              onTap: selectedImage == null ? () => this.pickImage() : null,
              trailing: selectedImage == null
                  ? null
                  : OutlinedButton(
                      onPressed: () => this.pickImage(),
                      child: Text(
                        "Täzele",
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
              title: Text(
                selectedImage == null
                    ? "Suart saýla"
                    : selectedImage.names.map((e) => e).toList().join(', '),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: LabeledInput(
            editMode: true,
            controller: imageLinkController,
            label: 'Link',
          ),
        )
      ],
    );
  }
}
