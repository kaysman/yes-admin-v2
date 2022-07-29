import 'dart:convert';
import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-table.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ImageType { BRAND_LOGO, BRAND_IMAGE }

class UpdateBrandPage extends StatefulWidget {
  const UpdateBrandPage({Key? key, required this.brand}) : super(key: key);

  final BrandEntity brand;
  @override
  State<UpdateBrandPage> createState() => _UpdateBrandPageState();
}

class _UpdateBrandPageState extends State<UpdateBrandPage> {
  late BrandBloc brandBloc;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  FilePickerResult? _selectedLogoImage;
  bool _isSelected = false;

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        _selectedLogoImage = result;
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  String? logoUrl;
  bool editMode = false;

  @override
  void initState() {
    super.initState();

    titleController.text = widget.brand.name ?? '';
    _isSelected = widget.brand.vip ?? false;
    logoUrl = widget.brand.fullPathLogo;
    brandBloc = BlocProvider.of<BrandBloc>(context);
  }

  String? get getOldName => widget.brand.name;
  bool? get getOldVip => widget.brand.vip;
  String? get getOldLogo => widget.brand.logo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandBloc, BrandState>(
      listenWhen: (state1, state2) =>
          state1.brandUpdateStatus != state2.brandUpdateStatus ||
          state1.brandDeleteStatus != state2.brandDeleteStatus,
      listener: (context, state) {
        if (state.brandUpdateStatus == BrandUpdateStatus.success) {
          showSnackBar(context, Text('Updated successfully'),
              type: SnackbarType.success);
          Navigator.of(context).pop();
        }
        if (state.brandDeleteStatus == BrandDeleteStatus.success) {
          showSnackBar(context, Text('Deleted successfully'),
              type: SnackbarType.success);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
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
                    "Brand üýtget".toUpperCase(),
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
                      ],
                    ],
                  ),
                  SizedBox(height: 14),
                  ImageSelectCard(
                    // title: 'Logo sayla',
                    editMode: editMode,
                    image: _selectedLogoImage,
                    pickImage: () => pickImage(),
                  ),
                  SizedBox(height: 14),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: kGrey3Color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      title: Text("VIP",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
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
                    hintText: 'Brendiň ady *',
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Delete',
                        textColor: Colors.redAccent,
                        borderColor: Colors.redAccent,
                        hasBorder: true,
                        isLoading: state.brandDeleteStatus ==
                            BrandDeleteStatus.loading,
                        onPressed: () {
                          brandBloc.deleteBrand(widget.brand.id);
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        text: "Update",
                        isLoading: state.brandUpdateStatus ==
                            BrandUpdateStatus.loading,
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            BrandEntity data = BrandEntity(
                              name: checkIfChangedAndReturn(
                                  getOldName, titleController.text),
                              id: widget.brand.id,
                              vip: checkIfChangedAndReturn(
                                getOldVip,
                                _isSelected,
                              ),
                            );
                            List<FilePickerResult> files = [];
                            if (_selectedLogoImage != null) {
                              files.add(_selectedLogoImage!);
                            }
                            await brandBloc.updateBrand(files, data.toJson());
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
      },
    );
  }
}
