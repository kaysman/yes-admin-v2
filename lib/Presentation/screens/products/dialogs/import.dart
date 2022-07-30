import 'dart:io';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-update-img.dialog.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/theming.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FileSelectType { IMAGE, EXCEL }

class ImportDialog extends StatefulWidget {
  const ImportDialog({Key? key}) : super(key: key);

  @override
  State<ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ProductBloc productBloc;

  FileSelectType? selectType;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    super.initState();
  }

  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .45,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Import',
            style: Theme.of(context).textTheme.headline1,
          ),
          ExpandablePageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              SelectImageOrExcelView(
                onExcelSelect: () {
                  setState(() {
                    selectType = FileSelectType.EXCEL;
                  });
                  _pageController.nextPage(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.decelerate,
                  );
                },
                onImageSelect: () {
                  setState(() {
                    selectType = FileSelectType.IMAGE;
                  });
                  _pageController.nextPage(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.decelerate,
                  );
                },
              ),
              if (selectType == FileSelectType.IMAGE) ImageSelectView(),
              if (selectType == FileSelectType.EXCEL) ExcelSelectview(),
            ],
            // width: MediaQuery.of(context).size.width * 0.55,
            // child: BlocConsumer<ProductBloc, ProductState>(
            //     listenWhen: (state1, state2) =>
            //         state1.excelUploadStatus != state2.excelUploadStatus,
            //     listener: (_, state) {
            //       if (state.excelUploadStatus ==
            //           ProductExcelUploadStatus.success) {
            //         showDialog(
            //           context: context,
            //           builder: (context) {
            //             return AlertDialog(
            //               title: Text("Successully Uploaded"),
            //               actions: [
            //                 TextButton(
            //                   onPressed: () async {
            //                     await productBloc.getAllProducts();
            //                     Navigator.of(context).pop();
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: Text("OK"),
            //                 ),
            //               ],
            //             );
            //           },
            //         );
            //       } else if (state.excelUploadStatus ==
            //           ProductExcelUploadStatus.error) {
            //         showDialog(
            //           context: context,
            //           builder: (context) {
            //             return AlertDialog(
            //               title: Text("${state.uploadExcelErrorMessage}"),
            //               actions: [
            //                 TextButton(
            //                   onPressed: () {
            //                     Navigator.of(context).pop();
            //                   },
            //                   child: Text("OK"),
            //                 ),
            //               ],
            //             );
            //           },
            //         );
            //       }
            //     },
            //     builder: (context, state) {
            //       return Form(
            //         key: formKey,
            //         child: Row(
            //           children: [],
            //         ),
            //       );
            //     }),
          ),
        ],
      ),
    );
  }
}

class SelectImageOrExcelView extends StatelessWidget {
  const SelectImageOrExcelView(
      {Key? key, required this.onImageSelect, required this.onExcelSelect})
      : super(key: key);
  final VoidCallback onImageSelect;
  final VoidCallback onExcelSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onImageSelect,
            child: buildSelection('Surat yukle', context),
          ),
          InkWell(
            onTap: onExcelSelect,
            child: buildSelection('Excel yukle', context),
          ),
        ],
      ),
    );
  }

  buildSelection(String title, BuildContext context) {
    return DottedBorder(
      color: kswPrimaryColor,
      borderType: BorderType.RRect,
      dashPattern: [6, 2],
      radius: Radius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: kswPrimaryColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 45),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              // color: kWhite,
              ),
        ),
      ),
    );
  }
}

class ImageSelectView extends StatefulWidget {
  const ImageSelectView({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageSelectView> createState() => _ImageSelectViewState();
}

class _ImageSelectViewState extends State<ImageSelectView> {
  FilePickerResult? _selectedImage;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        allowMultiple: true,
        allowedExtensions: ['jpg', 'png', 'gif'],
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
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (p, c) => p.imageUploadStatus != c.imageUploadStatus,
      listener: (context, state) {
        if (state.imageUploadStatus == ProductImageUploadStatus.success) {
          showSnackBar(
            context,
            Text('Images uploaded successfully'),
            type: SnackbarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              if (_selectedImage == null)
                DottedBorderedItemSelectContainer(
                  onSelect: () => this.pickFile(),
                  selectTitle:
                      'Asakdaky duwma basyp suratlary saylap bilersiniz',
                  selectBtnText: 'Surat sayla',
                ),
              if (_selectedImage != null) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: GridView.builder(
                      itemCount: _selectedImage?.count ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        // childAspectRatio: 1 / 2,
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
                                    shadows: kBoxShadow,
                                    Icons.close,
                                    size: 14,
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        _selectedImage?.files.removeAt(index);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 14,
                ),
                Button(
                  text: 'Surat gosh',
                  onPressed: () => this.pickFile(),
                )
              ],
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    text: 'Cancel',
                    hasBorder: true,
                    borderColor: kGrey5Color,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Button(
                    text: 'Upload',
                    primary: kswPrimaryColor,
                    textColor: kWhite,
                    isLoading: state.imageUploadStatus ==
                        ProductImageUploadStatus.loading,
                    onPressed: () async {
                      await context
                          .read<ProductBloc>()
                          .uploadImage(_selectedImage?.files ?? []);
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class ExcelSelectview extends StatefulWidget {
  const ExcelSelectview({
    Key? key,
  }) : super(key: key);

  @override
  State<ExcelSelectview> createState() => _ExcelSelectviewState();
}

class _ExcelSelectviewState extends State<ExcelSelectview> {
  FilePickerResult? _selectedExcel;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        allowedExtensions: ['xlsx'],
      );
      if (result == null) return;
      setState(() {
        _selectedExcel = result;
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (p, c) => p.excelUploadStatus != c.excelUploadStatus,
      listener: (context, state) {
        if (state.excelUploadStatus == ProductExcelUploadStatus.success) {
          showSnackBar(
            context,
            Text('Excel uploaded successfully'),
            type: SnackbarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              if (_selectedExcel == null)
                DottedBorderedItemSelectContainer(
                  onSelect: () => this.pickFile(),
                  selectTitle: 'Asakdaky duwma basyp excel saylap bilersiniz',
                  selectBtnText: 'Excel sayla',
                ),
              if (_selectedExcel != null) ...[
                ImageSelectCard(
                  editMode: true,
                  isExcel: true,
                  image: _selectedExcel,
                  pickImage: () => this.pickFile(),
                ),
              ],
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    text: 'Cancel',
                    hasBorder: true,
                    borderColor: kGrey5Color,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Button(
                    text: 'Upload',
                    primary: kswPrimaryColor,
                    textColor: kWhite,
                    isLoading: state.excelUploadStatus ==
                        ProductExcelUploadStatus.loading,
                    onPressed: () async {
                      await context.read<ProductBloc>().uploadExcel(
                            _selectedExcel!.files.first.name,
                            _selectedExcel!.files.first.bytes!.toList(),
                          );
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}



// Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "Suratlary Yukle".toUpperCase(),
//                           style: Theme.of(context).textTheme.headline4,
//                         ),
//                         SizedBox(height: 20),
//                         if (_selectedImage == null)
//                           DottedBorderedItemSelectContainer(
//                             onSelect: () =>
//                                 this.pickFile(FileSelectType.IMAGE),
//                             selectTitle:
//                                 'Asakdaky duwma basyp suratlary yukalp bilersiniz',
//                             selectBtnText: 'Suratlary yuke',
//                           ),
//                         if (_selectedImage != null)
// Expanded(
//   flex: 2,
//   child: 
// ),
//         SizedBox(height: 20),
//         Button(
//           text: "Upload",
//           textColor: kWhite,
//           primary: kswPrimaryColor,
//           isLoading: state.excelUploadStatus ==
//               ProductExcelUploadStatus.loading,
//           onPressed: () {
//             // print("object");
//           },
//         ),
//       ],
//     ),
//   ),
// ),
// Expanded(
//   child: Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           "Excel Yukle".toUpperCase(),
//           style: Theme.of(context).textTheme.headline4,
//         ),
//         SizedBox(height: 20),
//         if (_selectedExcel == null)
//           DottedBorderedItemSelectContainer(
//             onSelect: () =>
//                 this.pickFile(FileSelectType.EXCEL),
//             selectTitle:
//                 'Asakdaky duwma basyp excel yukalp bilersiniz',
//             selectBtnText: 'Excel yuke',
//           ),
//         if (_selectedExcel != null)
//           ImageSelectCard(
//             isExcel: true,
//             editMode: true,
//             image: _selectedExcel,
//             pickImage: () =>
//                 this.pickFile(FileSelectType.EXCEL),
//           ),
//         SizedBox(height: 20),
//         Button(
//           text: "Upload",
//           isLoading: state.excelUploadStatus ==
//               ProductExcelUploadStatus.loading,
//           onPressed: () async {
//             if (_selectedExcel != null) {
//               // if On web `path` is always `null`,
//               // You should access `bytes` property instead
//              
//             }
//           },
//         ),
//       ],
//     ),
//   ),
// ),
