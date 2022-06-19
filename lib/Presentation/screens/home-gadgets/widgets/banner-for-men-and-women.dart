import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/image_preview.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
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
                    buildLinks(context),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black38,
                          width: 0.0,
                        ),
                      ),
                      child: ListTile(
                        onTap: _selectedImage_1 == null
                            ? () => this.pickImage(ImageType.IMAGE_1)
                            : null,
                        trailing: _selectedImage_1 == null
                            ? null
                            : OutlinedButton(
                                onPressed: () =>
                                    this.pickImage(ImageType.IMAGE_1),
                                child: Text(
                                  "Täzele",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ),
                        title: Text(
                          _selectedImage_1 == null
                              ? "Suart saýla"
                              : _selectedImage_1!.names
                                  .map((e) => e)
                                  .toList()
                                  .join(', '),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
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
                              type: HomeGadgetType.BANNER_FOR_MEN_AND_WOMEN,
                              apiUrls: [
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

  buildLinks(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: LabeledInput(
          editMode: true,
          controller: imageLink1Controller,
          label: 'Image Link',
        )),
        SizedBox(width: 14),
        Expanded(
          child: LabeledInput(
            editMode: true,
            controller: imageLink2Controller,
            label: 'Image Link',
          ),
        )
      ],
    );
  }
}
