import 'package:admin_v2/Presentation/screens/brands/brand-create.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/components/image_preview.dart';

class TwoSmallCards extends StatefulWidget {
  const TwoSmallCards({Key? key}) : super(key: key);

  @override
  State<TwoSmallCards> createState() => _TwoSmallCardsState();
}

class _TwoSmallCardsState extends State<TwoSmallCards> {
  FilePickerResult? _selectedLogoImage;
  FilePickerResult? _selectedImage;
  TextEditingController imageLink1Controller = TextEditingController();
  TextEditingController imageLink2Controller = TextEditingController();

  Future<void> pickImage(ImageType type) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        if (type == ImageType.BRAND_LOGO) {
          _selectedLogoImage = result;
        } else {
          _selectedImage = result;
        }
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
                        if (_selectedLogoImage != null) ...[
                          ImagePreview(selectedImage: _selectedLogoImage),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                        if (_selectedImage != null) ...[
                          ImagePreview(selectedImage: _selectedImage),
                        ],
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
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
                              onTap: _selectedLogoImage == null
                                  ? () => this.pickImage(ImageType.BRAND_LOGO)
                                  : null,
                              trailing: _selectedLogoImage == null
                                  ? null
                                  : OutlinedButton(
                                      onPressed: () =>
                                          this.pickImage(ImageType.BRAND_LOGO),
                                      child: Text(
                                        "Täzele",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ),
                              title: Text(
                                _selectedLogoImage == null
                                    ? "Suart saýla"
                                    : _selectedLogoImage!.names
                                        .map((e) => e)
                                        .toList()
                                        .join(', '),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
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
                            controller: imageLink1Controller,
                            label: 'Image Link',
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
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
                              onTap: _selectedImage == null
                                  ? () => this.pickImage(ImageType.BRAND_IMAGE)
                                  : null,
                              trailing: _selectedImage == null
                                  ? null
                                  : OutlinedButton(
                                      onPressed: () =>
                                          this.pickImage(ImageType.BRAND_IMAGE),
                                      child: Text(
                                        "Täzele",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ),
                              title: Text(
                                _selectedImage == null
                                    ? "Surat saýla"
                                    : _selectedImage!.names
                                        .map((e) => e)
                                        .toList()
                                        .join(', '),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
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
                            controller: imageLink2Controller,
                            label: 'Image Link',
                          ),
                        )
                      ],
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
}
