import 'dart:convert';

import 'package:admin_v2/Data/models/market/create-market.dart';
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
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ownerNameController = TextEditingController();
  FilePickerResult? _selectedLogoImage;

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() => _selectedLogoImage = result);
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
                "Market döret".toUpperCase(),
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
                  onTap: _selectedLogoImage == null ? this.pickImage : null,
                  trailing: _selectedLogoImage == null
                      ? null
                      : OutlinedButton(
                          onPressed: this.pickImage,
                          child: Text("Täzele",
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      )),
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
              TextFormField(
                controller: titleController,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Markediň ady *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Barada",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Salgysy",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: phoneNumberController,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Telefon *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: ownerNameController,
                decoration: InputDecoration(
                  labelText: "Eýesiniň ady",
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
                        if (_selectedLogoImage != null) {
                          logo64String =
                              '${base64.encode(_selectedLogoImage!.files[0].bytes as List<int>)}-ext-${_selectedLogoImage!.files[0].extension}';
                          ;
                        }
                        CreateMarketDTO data = CreateMarketDTO(
                          title: titleController.text,
                          logo: logo64String,
                          address: addressController.text,
                          description: descriptionController.text,
                          phoneNumber: phoneNumberController.text,
                          ownerName: ownerNameController.text,
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
