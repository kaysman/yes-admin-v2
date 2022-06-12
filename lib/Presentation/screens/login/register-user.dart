import 'dart:convert';

import 'package:admin_v2/Data/models/role.enum.dart';
import 'package:admin_v2/Data/models/user/register-user.model.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final adressController = TextEditingController();
  FilePickerResult? _selectedImage;
  RoleType? selectedRole;

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() => _selectedImage = result);
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
              if (_selectedImage != null) ...[
                ClipOval(
                  child: Image.memory(
                    _selectedImage!.files.first.bytes!,
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
                  onTap: _selectedImage == null ? this.pickImage : null,
                  trailing: _selectedImage == null
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
              TextFormField(
                controller: phoneNumberController,
                validator: phoneValidator,
                decoration: InputDecoration(
                  labelText: "Telefon belginiz *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: passwordController,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Acar sozi *",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: "Ady",
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: adressController,
                validator: emptyField,
                decoration: InputDecoration(
                  labelText: "Salgysy *",
                ),
              ),
              SizedBox(height: 14),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField2<RoleType>(
                  isExpanded: true,
                  validator: emptyField,
                  value: selectedRole,
                  onChanged: (val) {
                    selectedRole = val;
                  },
                  items: RoleType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name),
                    );
                  }).toList(),
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
                        String? image64String;
                        if (_selectedImage != null) {
                          image64String =
                              '${base64.encode(_selectedImage!.files[0].bytes as List<int>)}-ext-${_selectedImage!.files[0].extension}';
                          ;
                        }
                        RegisterUserDTO data = RegisterUserDTO(
                          address: adressController.text,
                          password: passwordController.text,
                          phoneNumber: phoneNumberController.text,
                          role: selectedRole!,
                          firstName: firstNameController.text,
                          image: image64String,
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
