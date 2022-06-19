import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cards2_3InHorizontalWithTitleAsImage extends StatefulWidget {
  const Cards2_3InHorizontalWithTitleAsImage({
    Key? key,
    required this.gadgetBloc,
  }) : super(key: key);

  final GadgetBloc gadgetBloc;

  @override
  State<Cards2_3InHorizontalWithTitleAsImage> createState() =>
      _Cards2_3InHorizontalWithTitleAsImageState();
}

class _Cards2_3InHorizontalWithTitleAsImageState
    extends State<Cards2_3InHorizontalWithTitleAsImage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FilePickerResult? selectedTitleImage;

  List<FilePickerResult> pickImages = [];

  List<GadgetCartItemModel> cartItems = [];

  Future<FilePickerResult?> pickImageAndReturn() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result != null) return result;
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 14),
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
                          onPressed: () async {
                            var res = await this.pickImageAndReturn();
                            if (res != null) {
                              setState(() {
                                selectedTitleImage = res;
                              });
                            }
                          },
                          child: Text(
                            selectedTitleImage == null
                                ? 'Surat sayla'
                                : "Täzele",
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                        title: Text(
                          selectedTitleImage == null
                              ? "e.g abc.jpg"
                              : selectedTitleImage!.names
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
                    SizedBox(height: 14),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          cartItems.add(GadgetCartItemModel());
                        });
                      },
                      child: Text('Add Card +'),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(cartItems.length, (index) {
                            var item = cartItems[index];
                            return buildImageWithLink(
                              context,
                              item.image,
                              item.textController,
                              () async {
                                var res = await this.pickImageAndReturn();
                                if (res != null) {
                                  setState(() {
                                    item.image = res;
                                  });
                                }
                              },
                              (value) {
                                setState(() {
                                  cartItems.remove(cartItems[value]);
                                });
                              },
                              index + 1,
                            );
                          }),
                        ),
                      ),
                    ),
                    BlocConsumer<GadgetBloc, GadgetState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return ButtonsForGadgetCreation(
                          // formKey: _formKey,
                          isLoading:
                              state.createStatus == GadgetCreateStatus.loading,
                          onPressed: () async {
                            // TODO: Validate image states

                            CreateGadgetModel model = CreateGadgetModel(
                              type: HomeGadgetType
                                  .CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE,
                              apiUrls: this
                                  .cartItems
                                  .map((e) => e.textController.text)
                                  .toList(),
                              queue: 1,
                            );
                            setState(() {
                              pickImages = this
                                  .cartItems
                                  .map(
                                    (e) => e.image!,
                                  )
                                  .toList();
                              pickImages.add(selectedTitleImage!);
                            });
                            print(pickImages.length);
                            await widget.gadgetBloc.createHomeGadget(
                              pickImages,
                              model.toJson(),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Card(
                child: Container(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageWithLink(
    BuildContext context,
    FilePickerResult? image,
    TextEditingController? imageLinkController,
    VoidCallback onImageChanged,
    ValueChanged<int> onDelete,
    int? index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        children: [
          Text("$index"),
          SizedBox(width: 14),
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black38,
                  width: 0.0,
                ),
              ),
              child: ListTile(
                trailing: OutlinedButton(
                  onPressed: onImageChanged,
                  child: Text(
                    image == null ? 'Surat sayla' : "Täzele",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                title: Text(
                  image == null
                      ? "e.g abc.jpg"
                      : image.names.map((e) => e).toList().join(', '),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: LabeledInput(
              editMode: true,
              controller: imageLinkController,
              label: 'Link',
            ),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 50,
            height: 50,
            child: Card(
              child: IconButton(
                onPressed: () {
                  if (index != null) {
                    onDelete.call(index - 1);
                  }
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
