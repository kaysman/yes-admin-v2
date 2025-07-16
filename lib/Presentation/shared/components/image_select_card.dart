import 'package:admin_v2/Presentation/shared/app_colors.dart';
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
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
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
              color: Theme.of(context).dividerColor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          margin: EdgeInsets.zero,
          child: ListTile(
            trailing: ElevatedButton(
              onPressed: editMode ?? false ? this.pickImage : null,
              child: Text(image == null ? "Saýla" : "Täzele",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
            ),
            title: Text(
              image == null
                  ? 'eg: img.jpg'
                  : image!.names.map((e) => e).toList().join(', '),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: image == null 
                        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
