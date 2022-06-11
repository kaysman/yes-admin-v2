import 'dart:convert';
import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateMarketPage extends StatefulWidget {
  const CreateMarketPage({Key? key}) : super(key: key);

  @override
  State<CreateMarketPage> createState() => _CreateMarketPageState();
}

class _CreateMarketPageState extends State<CreateMarketPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  FilePickerResult? _selectedLogoImage;
  FilePickerResult? _selectedImage;
  bool _isSelected = false;

  Future<void> pickImage(FilePickerResult? selectedImage) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() => selectedImage = result);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
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
              SizedBox(height: 20),
              if (_selectedLogoImage != null) ...[
                ClipOval(
                  child: Image.memory(
                    _selectedLogoImage!.files.first.bytes!,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
                SizedBox(height: 14),
              ],
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black38,
                    width: 0.0,
                  ),
                ),
                child: ListTile(
                  onTap: () => _selectedLogoImage == null
                      ? this.pickImage(_selectedLogoImage)
                      : null,
                  trailing: _selectedLogoImage == null
                      ? null
                      : OutlinedButton(
                          onPressed: () => this.pickImage(_selectedLogoImage),
                          child: Text(
                            "Täzele",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                  title: Text(
                    _selectedLogoImage == null
                        ? "Logo saýla"
                        : _selectedLogoImage!.names
                            .map((e) => e)
                            .toList()
                            .join(', '),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 14),
              Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black38,
                    width: 0.0,
                  ),
                ),
                child: ListTile(
                  onTap: () => _selectedImage == null
                      ? this.pickImage(_selectedImage)
                      : null,
                  trailing: _selectedImage == null
                      ? null
                      : OutlinedButton(
                          onPressed: () => this.pickImage(_selectedImage),
                          child: Text(
                            "Täzele",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
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
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 14),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Vip',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 24,
                  ),
                  Checkbox(
                      value: this._isSelected,
                      onChanged: (val) {
                        setState(
                          () {
                            _isSelected = val!;
                          },
                        );
                      })
                ],
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: titleController,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Brendiň ady *",
                ),
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
