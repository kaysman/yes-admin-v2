import 'dart:io';
import 'dart:math';
import 'package:admin_v2/Data/models/product/image.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/response.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class ProductPickUpdateImages extends StatefulWidget {
  ProductPickUpdateImages({
    Key? key,
    required this.onSelectedIMages,
    required this.onSave,
    required this.pageController,
    required this.updateLoading,
    this.product,
    this.onDelete,
    required this.deleteLoading,
  }) : super(key: key);
  final ValueChanged<FilePickerResult> onSelectedIMages;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final PageController pageController;
  final bool updateLoading;
  final bool deleteLoading;
  final ProductEntity? product;
  @override
  State<ProductPickUpdateImages> createState() =>
      __ProductPickUpdateImagesState();
}

class __ProductPickUpdateImagesState extends State<ProductPickUpdateImages> {
  FilePickerResult? _selectedImage;
  // List<File>? my;

  @override
  void initState() {
    super.initState();
  }

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
          // _selectedImages = result.paths.map((path) => File(path!)).toList();
        } else if (_selectedImage != null) {
          // _selectedImages.add(result);
          _selectedImage?.files.addAll(result.files);
          // var images = resul;
          // _selectedImages = result;
          // var images = result.paths.map((path) => File(path!)).toList();
          // _selectedImages?.addAll(images);
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
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, color: kBlack),
              ),
              Text(
                "Harydyn suratlary".toUpperCase(),
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                "2/2",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
                    crossAxisCount: 3,
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
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 20,
                                icon: Icon(
                                  Icons.close,
                                  size: 15,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedImage?.files.removeAt(index);
                                  });
                                },
                              ),
                            ),
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
              child: DottedBorderedItemSelectContainer(
                onSelect: () async {
                  await pickImage();
                  widget.onSelectedIMages.call(_selectedImage!);
                },
                selectTitle:
                    'Suratlary asakdaky duwma basyp saylap bilersiniz!',
                selectBtnText: 'Surat sayla',
              ),
            ),
          if (_selectedImage != null)
            Button(
              text: 'Surat gosh',
              onPressed: () async {
                await pickImage();
              },
            ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(
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
                  Button(
                    text: 'Delete',
                    hasBorder: true,
                    textColor: Colors.redAccent,
                    borderColor: Colors.redAccent,
                    isLoading: widget.deleteLoading,
                    onPressed: widget.onDelete,
                  ),
                  SizedBox(width: 16),
                  Button(
                    primary: kswPrimaryColor,
                    textColor: kWhite,
                    text: "Update",
                    isLoading: widget.updateLoading,
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

class DottedBorderedItemSelectContainer extends StatelessWidget {
  const DottedBorderedItemSelectContainer({
    Key? key,
    required this.onSelect,
    required this.selectTitle,
    required this.selectBtnText,
  }) : super(key: key);
  final VoidCallback onSelect;
  final String selectTitle;
  final String selectBtnText;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: kswPrimaryColor,
      borderType: BorderType.RRect,
      dashPattern: [6, 2],
      radius: Radius.circular(10),
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: kswPrimaryColor.withOpacity(.35),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectTitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: kGrey1Color, fontSize: 18)),
            SizedBox(
              height: 14,
            ),
            Button(
              text: selectBtnText,
              textColor: kWhite,
              primary: kswPrimaryColor,
              onPressed: onSelect,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
