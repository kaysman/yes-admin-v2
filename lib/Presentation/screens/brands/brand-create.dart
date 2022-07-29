import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ImageType { BRAND_LOGO, BRAND_IMAGE }

class CreateBrandPage extends StatefulWidget {
  const CreateBrandPage({Key? key}) : super(key: key);

  @override
  State<CreateBrandPage> createState() => _CreateBrandPageState();
}

class _CreateBrandPageState extends State<CreateBrandPage> {
  late BrandBloc brandBloc;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  FilePickerResult? _selectedLogoImage;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    brandBloc = BlocProvider.of<BrandBloc>(context);
  }

  Future<void> pickImage(ImageType type) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        if (type == ImageType.BRAND_LOGO) {
          _selectedLogoImage = result;
        }
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrandBloc, BrandState>(
      listenWhen: (s1, s2) => s1.createStatus != s2.createStatus,
      listener: (context, state) {
        if (state.createStatus == BrandCreateStatus.success) {
          Navigator.of(context).pop();
          showSnackBar(
            context,
            Text(
              'Created Successully',
            ),
            type: SnackbarType.success,
          );
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
                    "Brand döret".toUpperCase(),
                    style: Theme.of(context).textTheme.headline4,
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
                    ],
                  ),
                  SizedBox(height: 14),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: kCardBorder,
                    child: ListTile(
                      onTap: _selectedLogoImage == null
                          ? () => this.pickImage(ImageType.BRAND_LOGO)
                          : null,
                      trailing: _selectedLogoImage == null
                          ? null
                          : OutlinedButton(
                              onPressed: () =>
                                  this.pickImage(ImageType.BRAND_LOGO),
                              child: Text(
                                "Täzele",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
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
                      side: BorderSide(color: kGrey3Color),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      side: BorderSide(color: kGrey1Color),
                      title: Text("VIP",
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  )),
                      value: this._isSelected,
                      onChanged: (val) {
                        setState(() => _isSelected = val!);
                      },
                    ),
                  ),
                  SizedBox(height: 14),
                  LabeledInput(
                    controller: titleController,
                    validator: emptyField,
                    hintText: "Brendiň ady *",
                    editMode: true,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      Button(
                        isLoading:
                            state.createStatus == BrandCreateStatus.loading,
                        text: "Save",
                        textColor: kWhite,
                        primary: kswPrimaryColor,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (_selectedLogoImage != null) {
                              List<FilePickerResult> _files = [];
                              _files.add(_selectedLogoImage!);
                              CreateBrandDTO data = CreateBrandDTO(
                                name: titleController.text,
                                vip: _isSelected,
                              );

                              brandBloc.createBrand(
                                _files,
                                data.toJson(),
                              );
                            }
                          }
                        },
                      )
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
