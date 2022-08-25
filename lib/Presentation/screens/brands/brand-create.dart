import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';
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
          showSnackbar(
            context,
            Snackbar(
              content: Text('Created successfully'),
            ),
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
                    style: FluentTheme.of(context).typography.body?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                  ),
                  SizedBox(height: 20),
                  buildImageReview(),
                  SizedBox(height: 14),
                  ImageSelectCard(
                    editMode: true,
                    image: _selectedLogoImage,
                    pickImage: () => this.pickImage(ImageType.BRAND_LOGO),
                  ),
                  SizedBox(height: 14),
                  buildVipInput(),
                  SizedBox(height: 14),
                  FluentLabeledInput(
                    controller: titleController,
                    isEditMode: true,
                    isTapped: false,
                    label: 'Brendin ady',
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      f.Button(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      f.Button(
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

  buildImageReview() {
    return Row(
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
    );
  }

  buildVipInput() {
    return GestureDetector(
      onTap: () => setState(() {
        _isSelected = !_isSelected;
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vip',
            style: FluentTheme.of(context).typography.body?.copyWith(
                  color: kGrey1Color,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(
                  color: kGrey3Color,
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Vip'),
                Checkbox(
                  checked: this._isSelected,
                  onChanged: (v) {
                    setState(() {
                      _isSelected = v!;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
