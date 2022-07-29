import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
                color: kGrey1Color,
              ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          margin: EdgeInsets.zero,
          shape: kCardBorder,
          child: ListTile(
            trailing: OutlinedButton(
              onPressed: editMode ?? false ? this.pickImage : null,
              child: Text(image == null ? "Saýla" : "Täzele",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).primaryColor,
                      )),
            ),
            title: Text(
              image == null
                  ? 'eg: img.jpg'
                  : image!.names.map((e) => e).toList().join(', '),
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
