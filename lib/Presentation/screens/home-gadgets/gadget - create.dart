import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-link.model.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-subcategory.model.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/gadget-review.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/models/gadget/create-gadget-product.model.dart';
import '../../../Data/models/gadget/gadget-link.model.dart';
import '../../shared/components/button.dart';
import '../../shared/components/image_select_card.dart';
import '../../shared/components/info.label.dart';
import '../../shared/components/input_fields.dart';

class CreateMainPage extends StatefulWidget {
  const CreateMainPage({Key? key}) : super(key: key);

  @override
  State<CreateMainPage> createState() => _CreateMainPageState();
}

class _CreateMainPageState extends State<CreateMainPage> {
  late GadgetType selectedType;
  late GadgetBloc gadgetBloc;

  @override
  void initState() {
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    selectedType = GadgetType.TWO_SMALL_CARDS_HORIZONTAL;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainHaight = MediaQuery.of(context).size.height * 0.9;
    double mainWidth = MediaQuery.of(context).size.width * 0.7;
    return Container(
      height: mainHaight,
      width: mainWidth,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sahypa döret".toUpperCase(),
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 14),
            Container(
              color: kScaffoldBgColor,
              height: mainHaight * .25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: GadgetType.values.length,
                itemBuilder: (context, index) {
                  var item = GadgetType.values[index];
                  var isSelected = item == selectedType;
                  return SizedBox(
                    width: 200,
                    child: Card(
                      child: ListTile(
                        tileColor:
                            isSelected ? kPrimaryColor.withOpacity(0.2) : null,
                        title: Text(item.name),
                        onTap: () {
                          setState(() {
                            selectedType = item;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 14),
            Expanded(
              child: Container(
                width: double.infinity,
                child: GadgetCreateBody(
                  isProduct: selectedType ==
                      GadgetType
                          .TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
                  isCategory: selectedType == GadgetType.CIRCLE_ITEMS ||
                      selectedType == GadgetType.CATEGORY_BANNER,
                  itemCount: selectedType.itemCount,
                  type: selectedType,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GadgetCreateBody extends StatefulWidget {
  const GadgetCreateBody({
    Key? key,
    required this.type,
    required this.itemCount,
    required this.isProduct,
    required this.isCategory,
  }) : super(key: key);

  final GadgetType type;
  final int itemCount;
  final bool isProduct;
  final bool isCategory;

  @override
  State<GadgetCreateBody> createState() => _GadgetCreateBodyState();
}

class _GadgetCreateBodyState extends State<GadgetCreateBody> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late GadgetBloc gadgetBloc;
  String? title;
  int? queue;
  GadgetStatus? status;
  GadgetLocation? location;

  List<GadgetLink> linkAndImgs = [];

  @override
  void initState() {
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    linkAndImgs = List.generate(
      widget.itemCount,
      (index) => GadgetLink(link: ''),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GadgetCreateBody oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      linkAndImgs = List.generate(
        widget.itemCount,
        (index) => GadgetLink(link: ''),
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GadgetBloc, GadgetState>(
      listenWhen: (p, c) => p.createStatus != c.createStatus,
      listener: (context, state) {
        if (state.createStatus == GadgetCreateStatus.success) {
          showSnackBar(
            context,
            Text('Created successfully'),
            type: SnackbarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: MyWidget(
                    onLocationCahnged: (v) {
                      setState(() {
                        location = v;
                      });
                    },
                    onStatusChanged: (v) {
                      setState(() {
                        status = v;
                      });
                    },
                    onSave: () async {
                      if (_formKey.currentState!.validate()) {
                        var links;
                        if (widget.isProduct) {
                          links = linkAndImgs
                              .map(
                                (e) => CreateGadgetProducts(
                                  productId: int.parse(e.link),
                                ),
                              )
                              .toList();
                        } else if (widget.isCategory) {
                          var subItems = linkAndImgs
                              .map(
                                (e) => CreateGadgetSubCategory(
                                  categoryId: int.parse(e.link),
                                ),
                              )
                              .toList();
                          links = linkAndImgs
                              .map(
                                (e) => CreateGadgetSubCategory(
                                  categoryId: int.parse(e.link),
                                ),
                              )
                              .toList();
                        } else {
                          links = linkAndImgs
                              .map(
                                (e) => CreateGadgetLink(
                                  link: e.link,
                                ),
                              )
                              .toList();
                        }

                        CreateGadgetModel model = CreateGadgetModel(
                          type: widget.type,
                          location: location,
                          categories: widget.isCategory ? links : null,
                          productIds: widget.isProduct ? links : null,
                          queue: queue,
                          status: status,
                          title: title,
                          links: widget.isProduct ? [] : links,
                        );
                        var files = linkAndImgs.map((e) => e.image).toList();
                        print(model.toJson());
                        await gadgetBloc.createHomeGadget(
                            files, model.toJson());
                      }
                    },
                    onTitleImageChanged: (v) {
                      GadgetLink image = GadgetLink(link: '', image: v);
                      setState(() {
                        linkAndImgs.add(image);
                      });
                    },
                    onTitleTextChanged: (v) {
                      setState(() {
                        title = v;
                      });
                    },
                    type: widget.type,
                    linkAndImgs: linkAndImgs,
                    onItemListChanged: (v) {
                      setState(() {
                        linkAndImgs = v;
                      });
                    },
                    onQueueChanged: (v) {
                      setState(() {
                        if (v != null) {
                          queue = int.tryParse(v);
                        }
                      });
                    },
                    isSaving: state.createStatus == GadgetCreateStatus.loading,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: GadgetReview(
                    imgPath: widget.type.previewImagePath,
                    description: widget.type.previewDescription,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({
    Key? key,
    required this.type,
    required this.linkAndImgs,
    required this.onItemListChanged,
    required this.onTitleTextChanged,
    required this.onTitleImageChanged,
    required this.onSave,
    required this.onStatusChanged,
    required this.onLocationCahnged,
    required this.onQueueChanged,
    required this.isSaving,
  }) : super(key: key);

  final GadgetType type;
  final ValueChanged<String?> onTitleTextChanged;
  final VoidCallback onSave;
  final ValueChanged<FilePickerResult> onTitleImageChanged;
  final List<GadgetLink> linkAndImgs;
  final ValueChanged<GadgetStatus> onStatusChanged;
  final ValueChanged<GadgetLocation> onLocationCahnged;
  final ValueChanged<List<GadgetLink>> onItemListChanged;
  final ValueChanged<String?> onQueueChanged;
  final bool isSaving;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<GadgetLink> linkAndImgs = [];
  FilePickerResult? selectedTitleImage;
  GadgetStatus? status;
  GadgetLocation? location;

  @override
  void initState() {
    linkAndImgs = widget.linkAndImgs;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyWidget oldWidget) {
    if (oldWidget.linkAndImgs != widget.linkAndImgs) {
      linkAndImgs = widget.linkAndImgs;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type;
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .07,
            child: LabeledInput(
              editMode: true,
              hintText: 'Tertibi',
              onChanged: widget.onQueueChanged,
            ),
          ),
          SizedBox(
            height: 14,
          ),
          statusAndLocation(),
          if (type == GadgetType.TWO_TO_TWO_WITH_TITLE_AS_IMAGE ||
              type == GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE ||
              type ==
                  GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE) ...[
            SizedBox(height: 14),
            ImageSelectCard(
              editMode: true,
              image: selectedTitleImage,
              pickImage: () {
                this.pickImage();
                if (selectedTitleImage != null) {
                  widget.onTitleImageChanged.call(selectedTitleImage!);
                }
              },
            ),
          ],
          if (type == GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT ||
              type == GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT ||
              type == GadgetType.THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT ||
              type == GadgetType.TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT ||
              type ==
                  GadgetType
                      .TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT) ...[
            LabeledInput(
              onChanged: widget.onTitleTextChanged,
              hintText: 'Title text',
              editMode: true,
              validator: emptyField,
            )
          ],
          SizedBox(height: 14),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(linkAndImgs.length, (index) {
                  final item = linkAndImgs[index];
                  return LinkAndImageTile(
                    isCategory: widget.type == GadgetType.CIRCLE_ITEMS ||
                        widget.type == GadgetType.CATEGORY_BANNER,
                    isProduct: widget.type ==
                        GadgetType
                            .TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
                    link: item.link,
                    onLinkChanged: (v) {
                      linkAndImgs[index].link = v!;
                      widget.onItemListChanged(linkAndImgs);
                    },
                    image: item.image,
                    onImageChanged: (v) {
                      linkAndImgs[index].image = v;
                      widget.onItemListChanged(linkAndImgs);
                    },
                  );
                }),
                SizedBox(height: 14),
                if (type == GadgetType.BANNER_SWIPE_WITH_DOTS ||
                    type ==
                        GadgetType
                            .CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE ||
                    type ==
                        GadgetType
                            .CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT ||
                    type ==
                        GadgetType
                            .CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE ||
                    type ==
                        GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT ||
                    type == GadgetType.CATEGORY_BANNER ||
                    type == GadgetType.CIRCLE_ITEMS ||
                    type ==
                        GadgetType
                            .TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT) ...[
                  OutlinedButton(
                    onPressed: () {
                      linkAndImgs.add(GadgetLink(link: ''));
                      widget.onItemListChanged(linkAndImgs);
                    },
                    child: Text('Add Card +'),
                  ),
                ],
              ],
            ),
          )),
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
              SizedBox(width: 16),
              Button(
                isLoading: widget.isSaving,
                text: "Save",
                primary: kswPrimaryColor,

                textColor: kWhite,
                onPressed: widget.onSave,
                // if (widget.formKey!.currentState!.validate()) {
                //   widget.onPressed.call();
                // }
                // print('---- Checking ------');
                // linkAndImgs.forEach((e) {
                //   print('Link: ${e.link}, Image: ${e.image?.names.first}');
                // });
                // print('------ end ----------');
              ),
            ],
          ),
        ],
      ),
    );
  }

  statusAndLocation() {
    return RowOfTwoChildren(
      child1: InfoWithLabel<GadgetStatus>(
        editMode: true,
        hintText: 'Gadget status',
        validator: notSelectedItem,
        label: 'Status',
        value: status,
        onValueChanged: (v) {
          widget.onStatusChanged.call(v!);
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
        validator: notSelectedItem,
        label: 'Location',
        value: location,
        onValueChanged: (v) {
          widget.onLocationCahnged.call(v!);
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
    );
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      setState(() {
        selectedTitleImage = result;
      });
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }
}

class LinkAndImageTile extends StatelessWidget {
  LinkAndImageTile({
    Key? key,
    this.onLinkChanged,
    this.onImageChanged,
    required this.link,
    this.image,
    this.isCategory = false,
    this.isProduct = false,
  }) : super(key: key);

  final String link;
  final ValueChanged<String?>? onLinkChanged;

  final FilePickerResult? image;
  final ValueChanged<FilePickerResult?>? onImageChanged;
  final bool isCategory;
  final bool isProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: ImageSelectCard(
              editMode: true,
              image: image,
              pickImage: this.pickImage,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: LabeledInput(
              editMode: true,
              hintText: isCategory
                  ? 'Category Id'
                  : isProduct
                      ? 'Product Id'
                      : 'Link',
              initialValue: this.link,
              onChanged: this.onLinkChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      this.onImageChanged?.call(result);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }
}
