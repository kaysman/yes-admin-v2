import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Data/models/gadget/gadget-cart-item.model.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/gadget-review.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
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
  GadgetStatus? status;
  GadgetLocation? location;

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
                    ImageSelectCard(
                      editMode: true,
                      image: selectedTitleImage,
                      pickImage: () async {
                        var res = await this.pickImageAndReturn();
                        if (res != null) {
                          setState(() {
                            selectedTitleImage = res;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 14),
                    RowOfTwoChildren(
                      child1: InfoWithLabel<GadgetStatus>(
                        editMode: true,
                        hintText: 'Gadget status',
                        label: 'Status',
                        value: status,
                        onValueChanged: (v) {
                          setState(() {
                            status = v;
                          });
                        },
                        items: GadgetStatus.values
                            .map(
                              (e) => DropdownMenuItem<GadgetStatus>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                      ),
                      child2: InfoWithLabel<GadgetLocation>(
                        editMode: true,
                        hintText: 'Gadget status',
                        label: ' Location',
                        value: location,
                        onValueChanged: (v) {
                          setState(() {
                            location = v;
                          });
                        },
                        items: GadgetLocation.values
                            .map(
                              (e) => DropdownMenuItem<GadgetLocation>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
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
                          formKey: _formKey,
                          isLoading:
                              state.createStatus == GadgetCreateStatus.loading,
                          onPressed: () async {
                            // TODO: Validate image states

                            CreateGadgetModel model = CreateGadgetModel(
                              location: location,
                              status: status,
                              type: HomeGadgetType
                                  .CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE,
                              links: this
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
              child: GadgetReview(
                imgPath: '16-16-horizontal-title-as-text.png',
                description: 'Dummy Text',
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$index"),
          SizedBox(width: 14),
          Expanded(
              child: ImageSelectCard(
            editMode: true,
            image: image,
            pickImage: onImageChanged,
          )),
          SizedBox(width: 14),
          Expanded(
            child: LabeledInput(
              editMode: true,
              controller: imageLinkController,
              hintText: 'Link',
            ),
          ),
          SizedBox(width: 5),
          GadgetRemoveBtn(
            onRemove: () {
              if (index != null) {
                onDelete.call(index - 1);
              }
            },
          )
        ],
      ),
    );
  }
}

class GadgetRemoveBtn extends StatelessWidget {
  const GadgetRemoveBtn({
    Key? key,
    required this.onRemove,
  }) : super(key: key);

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Card(
        child: IconButton(
          onPressed: onRemove,
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
