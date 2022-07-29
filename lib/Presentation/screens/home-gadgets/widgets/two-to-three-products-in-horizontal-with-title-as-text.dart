import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Data/models/gadget/gadget-cart-item.model.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/buttons.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/cards-2_3-horizontal-with-title-as-image.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/gadget-review.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/image_select_card.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TwoToThreeProductsInHorizontalWithTitleAsText extends StatefulWidget {
  const TwoToThreeProductsInHorizontalWithTitleAsText({
    Key? key,
    required this.gadgetBloc,
  }) : super(key: key);

  final GadgetBloc gadgetBloc;

  @override
  State<TwoToThreeProductsInHorizontalWithTitleAsText> createState() =>
      _TwoToThreeProductsInHorizontalWithTitleAsTextState();
}

class _TwoToThreeProductsInHorizontalWithTitleAsTextState
    extends State<TwoToThreeProductsInHorizontalWithTitleAsText> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();

  List<GadgetCartItemModel> cartItems = [];
  GadgetStatus? status;
  GadgetLocation? location;

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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    LabeledInput(
                      editMode: true,
                      controller: titleController,
                      hintText: 'Title text',
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
                            CreateGadgetModel model = CreateGadgetModel(
                              location: location,
                              status: status,
                              type: HomeGadgetType
                                  .TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
                              links: [],
                              queue: 1,
                              productIds: this
                                  .cartItems
                                  .map((e) => e.textController.text)
                                  .toList(),
                              title: titleController.text,
                            );
                            await widget.gadgetBloc.createHomeGadget(
                              this
                                  .cartItems
                                  .map(
                                    (e) => e.image!,
                                  )
                                  .toList(),
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
                imgPath: 'products.png',
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
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
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
              hintText: 'Harydyn id-sy',
            ),
          ),
          SizedBox(width: 5),
          GadgetRemoveBtn(onRemove: () {
            onDelete.call(index - 1);
          })
        ],
      ),
    );
  }
}
