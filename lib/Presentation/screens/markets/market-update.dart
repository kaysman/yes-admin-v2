import 'dart:convert';

import 'package:admin_v2/Data/models/market/create-market.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateMarketPage extends StatefulWidget {
  const UpdateMarketPage({
    Key? key,
    required this.market,
  }) : super(key: key);

  final MarketEntity market;

  @override
  State<UpdateMarketPage> createState() => UpdateMarketPageState();
}

class UpdateMarketPageState extends State<UpdateMarketPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final ownerNameController = TextEditingController();
  String? photoUrl;

  FilePickerResult? _selectedLogoImage;
  bool editMode = false;

  @override
  void initState() {
    titleController.text = widget.market.title;
    addressController.text = widget.market.address ?? '';
    descriptionController.text = widget.market.description ?? '';
    phoneNumberController.text = widget.market.phoneNumber;
    ownerNameController.text = widget.market.ownerName ?? '';
    photoUrl = widget.market.fullPathImage;
    super.initState();
  }

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
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => setState(() => editMode = !editMode),
                child: Text(
                  editMode ? "Cancel" : "Üýtget",
                  // style: Theme.of(context).textTheme.caption,
                ),
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
              if (_selectedLogoImage == null && photoUrl != null) ...[
                ClipOval(
                  child: Image.network(
                    photoUrl!,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
                SizedBox(height: 14),
              ],
              ImageSelectCard(
                title: "Logo saýla",
                image: _selectedLogoImage,
                pickImage: pickImage,
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: titleController,
                label: "Markediň ady *",
                validator: emptyField,
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: descriptionController,
                label: "Barada",
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: addressController,
                label: "Salgysy",
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: phoneNumberController,
                validator: emptyField,
                label: "Telefon *",
                editMode: editMode,
              ),
              SizedBox(height: 14),
              LabeledInput(
                controller: ownerNameController,
                label: "Eýesiniň ady",
                editMode: editMode,
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
                  BlocConsumer<MarketBloc, MarketState>(listener: (_, state) {
                    // if (state.) {

                    // }
                  }, builder: (context, state) {
                    return Button(
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

                          // context.read<MarketBloc>().

                        }
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
