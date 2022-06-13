import 'dart:convert';
import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ImageType { BRAND_LOGO, BRAND_IMAGE }

class UpdateBrandPage extends StatefulWidget {
  const UpdateBrandPage({Key? key, required this.brand}) : super(key: key);

  final BrandEntity brand;
  @override
  State<UpdateBrandPage> createState() => _UpdateBrandPageState();
}

class _UpdateBrandPageState extends State<UpdateBrandPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  FilePickerResult? _selectedLogoImage;
  FilePickerResult? _selectedImage;
  bool _isSelected = false;

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

  String? photoUrl;
  String? logoUrl;
  bool editMode = false;

  @override
  void initState() {
    super.initState();

    titleController.text = widget.brand.name;
    _isSelected = widget.brand.vip;
    photoUrl = widget.brand.fullPathImage;
    logoUrl = widget.brand.fullPathLogo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Brand döret".toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => setState(() => editMode = !editMode),
                child: Text(
                  editMode ? "Cancel" : "Üýtget",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_selectedLogoImage != null) ...[
                    ClipOval(
                      child: Image.memory(
                        _selectedLogoImage!.files.first.bytes!,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                  ],
                  if (_selectedImage != null) ...[
                    ClipOval(
                      child: Image.memory(
                        _selectedImage!.files.first.bytes!,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 14),
              ImageSelectCard(
                title: 'Logo sayla',
                editMode: editMode,
                image: _selectedLogoImage,
                pickImage: () => pickImage(ImageType.BRAND_LOGO),
              ),
              SizedBox(height: 14),
              ImageSelectCard(
                title: 'Surat sayla',
                image: _selectedImage,
                editMode: editMode,
                pickImage: () => pickImage(ImageType.BRAND_IMAGE),
              ),
              SizedBox(height: 14),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black38, width: 0.0),
                ),
                child: CheckboxListTile(
                  title: Text("VIP",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          )),
                  value: this._isSelected,
                  onChanged: editMode
                      ? (val) {
                          setState(() => _isSelected = val!);
                        }
                      : null,
                ),
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController,
                editMode: editMode,
                validator: emptyField,
                label: 'Brendiň ady *',
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Button(
                    text: "Save",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String? logo64String;
                        String? image64String;
                        if (_selectedLogoImage != null ||
                            _selectedImage != null) {
                          logo64String =
                              '${base64.encode(_selectedLogoImage!.files[0].bytes as List<int>)}-ext-${_selectedLogoImage!.files[0].extension}';
                          ;
                          image64String =
                              '${base64.encode(_selectedImage!.files[0].bytes as List<int>)}-ext-${_selectedImage!.files[0].extension}';
                          ;
                        }
                        CreateBrandDTO data = CreateBrandDTO(
                          name: titleController.text,
                          logo: logo64String!,
                          image: image64String,
                          vip: this._isSelected,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
