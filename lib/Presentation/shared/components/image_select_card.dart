import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageSelectCard extends StatelessWidget {
  const ImageSelectCard({
    Key? key,
    this.editMode = false,
    this.pickImage,
    required this.title,
    this.image,
  }) : super(key: key);

  final bool? editMode;
  final VoidCallback? pickImage;
  final FilePickerResult? image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black38,
          width: 0.0,
        ),
      ),
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
              ? title
              : image!.names.map((e) => e).toList().join(', '),
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
