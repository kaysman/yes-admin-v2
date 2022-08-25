import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

class ImageSelectCard extends StatelessWidget {
  const ImageSelectCard({
    Key? key,
    this.editMode = false,
    this.pickImage,
    this.image,
    this.isExcel = false,
  }) : super(key: key);

  final bool? editMode;
  final bool? isExcel;
  final VoidCallback? pickImage;
  final FilePickerResult? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExcel == true ? 'Excel' : 'Surat',
          style: FluentTheme.of(context).typography.body!.copyWith(
                fontWeight: FontWeight.w500,
                color: kGrey1Color,
                fontSize: 18,
              ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: kGrey3Color,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.zero,
          child: ListTile(
            trailing: Button(
              onPressed: editMode ?? false ? this.pickImage : null,
              child: Text(image == null ? "Saýla" : "Täzele",
                  style: FluentTheme.of(context).typography.caption!.copyWith(
                        color: kPrimaryColor,
                      )),
            ),
            title: Text(
              image == null
                  ? 'eg: img.jpg'
                  : image!.names.map((e) => e).toList().join(', '),
              style: FluentTheme.of(context).typography.body!.copyWith(
                    color: image == null ? kGrey2Color : kText2Color,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
