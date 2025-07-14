import 'dart:io';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/theming.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductPickIMages extends StatefulWidget {
  ProductPickIMages({
    Key? key,
    required this.onSelectedIMages,
    required this.onSave,
    required this.pageController,
    required this.saveLoading,
    this.product,
    this.onDelete,
  }) : super(key: key);
  final ValueChanged<FilePickerResult> onSelectedIMages;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final PageController pageController;
  final bool saveLoading;
  final ProductEntity? product;
  @override
  State<ProductPickIMages> createState() => __ProductPickIMagesState();
}

class __ProductPickIMagesState extends State<ProductPickIMages> {
  FilePickerResult? _selectedImage;

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        allowMultiple: true,
        allowedExtensions: ['jpeg', 'jpg', 'png'],
        type: FileType.image,
      );
      if (result == null) return;
      setState(() {
        if (_selectedImage == null) {
          _selectedImage = result;
        } else if (_selectedImage != null) {
          _selectedImage?.files.addAll(result.files);
        }
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(FluentIcons.close_pane, color: kBlack),
                // child: const Icon(Icons.close, color: kBlack),
              ),
              Text(
                "Harydyn suratlary".toUpperCase(),
                style: FluentTheme.of(context).typography.bodyLarge,
              ),
              Text(
                "2/2",
                style: FluentTheme.of(context).typography.body?.copyWith(
                      color: kText2Color,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          if (_selectedImage != null) ...[
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              child: GridView.builder(
                  itemCount: _selectedImage?.count ?? 0,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var images =
                        _selectedImage?.paths.map((e) => File(e!)).toList();
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.file(
                            File(images![index].path),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              top: 2,
                              right: 2,
                              child: SmallCircleButton(
                                child: Icon(
                                  FluentIcons.close_pane,
                                  size: 12,
                                  shadows: kBoxShadow,
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedImage?.files.removeAt(index);
                                  });
                                },
                              )
                              // Card(

                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: IconButton(
                              //     padding: EdgeInsets.zero,
                              //     splashRadius: 20,
                              //     icon: Icon(
                              //       Icons.close,
                              //       size: 10,
                              //     ),
                              //     onPressed: () {

                              //     },
                              //   ),
                              // ),
                              ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
          ],
          if (_selectedImage == null)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kswPrimaryColor.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: DottedBorder(
                color: kswPrimaryColor,
                borderType: BorderType.RRect,
                dashPattern: [6, 2],
                radius: Radius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Suratlary asakdaky duwma basyp saylap bilersiniz!',
                          style: FluentTheme.of(context)
                              .typography
                              .body
                              ?.copyWith(color: kGrey1Color, fontSize: 18)),
                      SizedBox(
                        height: 14,
                      ),
                      f.Button(
                        text: 'Surat sayla',
                        textColor: kWhite,
                        primary: kswPrimaryColor,
                        onPressed: () async {
                          await pickImage();

                          widget.onSelectedIMages.call(_selectedImage!);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          if (_selectedImage != null)
            f.Button(
              text: 'Surat gosh',
              onPressed: () async {
                await pickImage();
              },
            ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              f.Button(
                primary: kswPrimaryColor,
                textColor: kWhite,
                text: "Back",
                onPressed: () {
                  widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.decelerate,
                  );
                },
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  f.Button(
                    primary: kswPrimaryColor,
                    textColor: kWhite,
                    text: "Save",
                    isLoading: widget.saveLoading,
                    onPressed: widget.onSave,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
