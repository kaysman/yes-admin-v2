import 'dart:io';

import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExcelUploadDialog extends StatefulWidget {
  const ExcelUploadDialog({Key? key}) : super(key: key);

  @override
  State<ExcelUploadDialog> createState() => _ExcelUploadDialogState();
}

class _ExcelUploadDialogState extends State<ExcelUploadDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FilePickerResult? _selectedFile;
  late ProductBloc productBloc;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        _selectedFile = result;
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: BlocConsumer<ProductBloc, ProductState>(
          listenWhen: (state1, state2) =>
              state1.excelUploadStatus != state2.excelUploadStatus,
          listener: (_, state) {
            if (state.excelUploadStatus == ProductExcelUploadStatus.success) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Successully Uploaded"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await productBloc.getAllProducts();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            } else if (state.excelUploadStatus ==
                ProductExcelUploadStatus.error) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("${state.uploadExcelErrorMessage}"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Excel Yukle".toUpperCase(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 20),
                    Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black38,
                          width: 0.0,
                        ),
                      ),
                      child: ListTile(
                        trailing: OutlinedButton(
                          onPressed: this.pickFile,
                          child: Text(
                            _selectedFile == null ? 'Sayla' : "Täzele",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                        title: Text(
                          _selectedFile == null
                              ? "Logo saýla"
                              : _selectedFile!.names
                                  .map((e) => e)
                                  .toList()
                                  .join(', '),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Button(
                      text: "Upload",
                      isLoading: state.excelUploadStatus ==
                          ProductExcelUploadStatus.loading,
                      onPressed: () async {
                        if (_selectedFile != null) {
                          // if On web `path` is always `null`,
                          // You should access `bytes` property instead
                          await productBloc.uploadExcel(
                            _selectedFile!.files.first.name,
                            _selectedFile!.files.first.bytes!.toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
