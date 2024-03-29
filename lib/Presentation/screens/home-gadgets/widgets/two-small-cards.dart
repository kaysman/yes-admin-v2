import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/image_preview.dart';
import '../bloc/gadget.bloc.dart';

class TwoSmallCards extends StatefulWidget {
  const TwoSmallCards({Key? key, required this.gadgetBloc}) : super(key: key);

  final GadgetBloc gadgetBloc;

  @override
  State<TwoSmallCards> createState() => _TwoSmallCardsState();
}

class _TwoSmallCardsState extends State<TwoSmallCards> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FilePickerResult? _selectedImage_1;
  FilePickerResult? _selectedImage_2;
  TextEditingController imageLink1Controller = TextEditingController();
  TextEditingController imageLink2Controller = TextEditingController();

  Future<FilePickerResult?> pickImageAndReturn() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result != null) return result;
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
                        if (_selectedImage_2 != null) ...[
                          ImagePreview(selectedImage: _selectedImage_2),
                        ],
                      ],
                    ),
                    SizedBox(height: 14),
                    buildImageWithLink(
                      context,
                      _selectedImage_1,
                      imageLink1Controller,
                      () async {
                        var res = await this.pickImageAndReturn();
                        if (res != null) {
                          setState(() {
                            _selectedImage_1 = res;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildImageWithLink(
                      context,
                      _selectedImage_2,
                      imageLink2Controller,
                      () async {
                        var res = await this.pickImageAndReturn();
                        if (res != null) {
                          setState(() {
                            _selectedImage_2 = res;
                          });
                        }
                      },
                    ),
                    Spacer(),
                    BlocConsumer<GadgetBloc, GadgetState>(
                      listener: (context, state) {},
                      listenWhen: (p, c) => p.createStatus != c.createStatus,
                      builder: (context, state) {
                        return ButtonsForGadgetCreation(
                          // formKey: _formKey,
                          isLoading:
                              state.createStatus == GadgetCreateStatus.loading,
                          onPressed: () async {
                            CreateGadgetModel model = CreateGadgetModel(
                              type: HomeGadgetType.TWO_SMALL_CARDS_HORIZONTAL,
                              apiUrls: [
                                imageLink1Controller.text,
                                imageLink2Controller.text
                              ],
                              queue: 1,
                            );
                            if (_selectedImage_1 != null &&
                                _selectedImage_2 != null) {
                              await widget.gadgetBloc.createHomeGadget(
                                [_selectedImage_1!, _selectedImage_2!],
                                model.toJson(),
                              );
                              print('object');
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

  buildImageWithLink(
    BuildContext context,
    FilePickerResult? image,
    TextEditingController? imageLinkController,
    VoidCallback onImageChanged,
  ) {
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
              trailing: OutlinedButton(
                onPressed: onImageChanged,
                child: Text(
                  image == null ? 'Surat sayla' : "Täzele",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
              title: Text(
                image == null
                    ? "e.g abc.jpg"
                    : image.names.map((e) => e).toList().join(', '),
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
            validator: emptyField,
            controller: imageLinkController,
            label: 'Link',
          ),
        )
      ],
    );
  }
}
