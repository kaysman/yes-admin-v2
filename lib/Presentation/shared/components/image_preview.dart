import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    Key? key,
    required FilePickerResult? selectedImage,
  })  : _selectedImage = selectedImage,
        super(key: key);

  final FilePickerResult? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.memory(
        _selectedImage!.files.first.bytes!,
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      ),
    );
  }
}
