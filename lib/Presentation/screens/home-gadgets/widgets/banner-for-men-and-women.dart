import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/image_preview.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ImageType { IMAGE_1, IMAGE_2, IMAGE_3, IMAGE_4, IMAGE_5 }

class BannerForMenAndWomen extends StatefulWidget {
  const BannerForMenAndWomen({Key? key}) : super(key: key);

  @override
  State<BannerForMenAndWomen> createState() => _BannerForMenAndWomenState();
}

class _BannerForMenAndWomenState extends State<BannerForMenAndWomen> {
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
