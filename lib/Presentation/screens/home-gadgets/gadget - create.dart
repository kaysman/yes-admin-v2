import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-link.model.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-product.model.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget-subcategory.model.dart';
import 'package:admin_v2/Data/models/gadget/create-gadget.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/widgets/gadget-review.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/models/gadget/gadget-link.model.dart';
import '../../shared/components/button.dart' as fl;
import '../../shared/components/image_select_card.dart';
import '../../shared/components/input_fields.dart';

final enabledgadgetTypes = [
  GadgetType.TWO_SMALL_CARDS_HORIZONTAL,
  GadgetType.BANNER_SWIPE_WITH_DOTS,
  GadgetType.BANNER_FOR_MEN_AND_WOMEN,
  GadgetType.TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT,
  GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
  GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE,
  GadgetType.THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT,
  GadgetType.ONE_IMAGE_WITH_FULL_WIDTH,
  GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
  GadgetType.TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
  GadgetType.CIRCLE_ITEMS,
  GadgetType.CATEGORY_BANNER
];

class CreateMainPage extends StatefulWidget {
  const CreateMainPage({Key? key}) : super(key: key);

  @override
  State<CreateMainPage> createState() => _CreateMainPageState();
}

class _CreateMainPageState extends State<CreateMainPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late GadgetType selectedType;
  // late EnabledGadgetTypes selectedType;

  late GadgetBloc gadgetBloc;

  String? titleText;

  FilePickerResult? titleImage;
  String? onImageLink;

  GadgetStatus? status;
  GadgetLocation? location;
  int? queue;

  List<GadgetLink> linkAndImgs = [];

  @override
  void initState() {
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    selectedType = GadgetType.TWO_SMALL_CARDS_HORIZONTAL;
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    linkAndImgs = List.generate(
      selectedType.itemCount,
      (index) => GadgetLink(controller: TextEditingController()),
    );
    super.initState();
  }

  onSavePressed() async {
    var isProduct = selectedType ==
        GadgetType.TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT;
    var isCategory = selectedType == GadgetType.CIRCLE_ITEMS ||
        selectedType == GadgetType.CATEGORY_BANNER;

    List<CreateGadgetProducts> pL = [];
    List<CreateGadgetSubCategory> cL = [];
    List<CreateGadgetLink> gL = [];
    // var links;
    if (isProduct) {
      var links = linkAndImgs
          .map(
            (e) => CreateGadgetProducts(
              productId: int.parse(e.controller.text),
            ),
          )
          .toList();
      pL.addAll(links);
    } else if (isCategory) {
      var links = linkAndImgs
          .map(
            (e) => CreateGadgetSubCategory(
              categoryId: int.parse(e.controller.text),
            ),
          )
          .toList();
      cL.addAll(links);
    } else {
      var links = linkAndImgs
          .map(
            (e) => CreateGadgetLink(
              link: e.controller.text,
            ),
          )
          .toList();
      if (onImageLink != null) {
        links.add(CreateGadgetLink(link: onImageLink!));
      }
      gL.addAll(links);
    }

    CreateGadgetModel model = CreateGadgetModel(
      type: selectedType,
      location: location,
      categories: isCategory ? cL : null,
      productIds: isProduct ? pL : null,
      queue: queue ?? 1,
      status: status,
      title: titleText,
      links: isProduct || isCategory ? [] : gL,
    );
    var files = linkAndImgs.map((e) => e.image).toList();
    log(model.toJson());
    await gadgetBloc.createHomeGadget(files, model.toJson());
  }

  @override
  Widget build(BuildContext context) {
    double mainHeight = MediaQuery.of(context).size.height * 0.9;
    double mainWidth = MediaQuery.of(context).size.width * 0.7;
    return Form(
      key: _formKey,
      child: Container(
        height: mainHeight,
        width: mainWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sahypa döret".toUpperCase(),
                style: FluentTheme.of(context).typography.title?.copyWith(
                      fontSize: 20,
                    ),
              ),
              SizedBox(height: 14),
              Container(
                // color: kScaffoldBgColor,
                height: mainHeight * .25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: enabledgadgetTypes.length,
                  itemBuilder: (context, index) {
                    var item = enabledgadgetTypes[index];
                    var isSelected = item == selectedType;
                    return Container(
                      width: 200,
                      child: GestureDetector(
                        onTap: () {
                          if (item != selectedType) {
                            setState(() {
                              selectedType = item;
                              linkAndImgs = List.generate(
                                selectedType.itemCount,
                                (index) => GadgetLink(
                                  controller: TextEditingController(),
                                ),
                              );
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? kPrimaryColor.withOpacity(.2)
                                : kGrey3Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(item.name),
                          ),
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
                    type: selectedType,
                    linkAndImgs: linkAndImgs,
                    onItemListChanged: (v) {
                      setState(() => linkAndImgs = v);
                    },
                    onLocationChanged: (v) {
                      setState(() {
                        location = v;
                      });
                    },
                    onQueueChanged: (v) {
                      setState(() {
                        if (v != null) {
                          queue = int.tryParse(v);
                        }
                      });
                    },
                    onStatusChanged: (v) {
                      setState(() {
                        status = v;
                      });
                    },
                    onTitleImageChanged: (v) {
                      setState(() {
                        titleImage = v;
                      });
                    },
                    onTitleTextChanged: (v) {
                      setState(() {
                        titleText = v;
                      });
                    },
                    onOneImageLinkChanged: (v) {
                      setState(() {
                        onImageLink = v;
                      });
                    },
                  ),
                ),
              ),
              BlocConsumer<GadgetBloc, GadgetState>(
                listenWhen: (p, c) => p.createStatus != c.createStatus,
                listener: (context, state) {
                  if (state.createStatus == GadgetCreateStatus.success) {
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
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      fl.Button(
                        text: 'Cancel',
                        hasBorder: true,
                        borderColor: kGrey5Color,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      fl.Button(
                        isLoading:
                            state.createStatus == GadgetCreateStatus.loading,
                        text: "Save",
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        onPressed: this.onSavePressed,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GadgetCreateBody extends StatefulWidget {
  const GadgetCreateBody({
    Key? key,
    required this.type,
    required this.linkAndImgs,
    required this.onItemListChanged,
    required this.onTitleTextChanged,
    required this.onTitleImageChanged,
    required this.onStatusChanged,
    required this.onLocationChanged,
    required this.onQueueChanged,
    this.titleText,
    this.titleImage,
    this.status,
    this.location,
    this.queue,
    required this.onOneImageLinkChanged,
  }) : super(key: key);

  final GadgetType type;

  final String? titleText;
  final ValueChanged<String?> onTitleTextChanged;

  final FilePickerResult? titleImage;
  final ValueChanged<FilePickerResult> onTitleImageChanged;

  final List<GadgetLink> linkAndImgs;
  final ValueChanged<List<GadgetLink>> onItemListChanged;
  final GadgetStatus? status;
  final ValueChanged<GadgetStatus> onStatusChanged;
  final GadgetLocation? location;
  final ValueChanged<GadgetLocation> onLocationChanged;
  final String? queue;
  final ValueChanged<String?> onQueueChanged;
  final ValueChanged<String?> onOneImageLinkChanged;

  @override
  State<GadgetCreateBody> createState() => _GadgetCreateBodyState();
}

class _GadgetCreateBodyState extends State<GadgetCreateBody> {
  GadgetStatus? status;
  GadgetLocation? location;

  TextEditingController _controller = TextEditingController();

  @override
  void didUpdateWidget(covariant GadgetCreateBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.type != widget.type) {
      location = null;
      status = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = this.widget.type;

    final expandableTypes = [
      GadgetType.BANNER_SWIPE_WITH_DOTS,
      GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE,
      GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
      GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
      GadgetType.CATEGORY_BANNER,
      GadgetType.CIRCLE_ITEMS,
      GadgetType.TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT
    ];

    final horizontalTypes = [
      GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
      GadgetType.CARDS_2_3_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
      GadgetType.THREE_TO_THREE_GRID_WITH_TITLE_AS_TEXT,
      GadgetType.TWO_TO_TWO_GRID_WITH_TITLE_AS_TEXT,
      GadgetType.TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
    ];

    final titledTypes = [
      GadgetType.CARDS_16_9_IN_HORIZONTAL_WITH_TITLE_AS_IMAGE,
    ];

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .07,
                  child: FluentLabeledInput(
                    controller: _controller,
                    isEditMode: true,
                    isTapped: false,
                    label: 'Tertibi',
                  ),
                ),
                SizedBox(height: 14),
                statusAndLocation(),
                if (titledTypes.contains(type)) ...[
                  SizedBox(height: 14),
                  ImageSelectCard(
                    editMode: true,
                    image: widget.titleImage,
                    pickImage: () => this.pickImage(),
                  ),
                ],
                if (horizontalTypes.contains(type)) ...[
                  FluentLabeledInput(
                    onChanged: this.widget.onTitleTextChanged,
                    label: 'Title text',
                    isEditMode: true,
                    isTapped: false,
                  )
                ],
                SizedBox(height: 14),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                        widget.linkAndImgs.length,
                        (index) {
                          final item = widget.linkAndImgs[index];
                          return LinkAndImageTile(
                            isCategory: this.widget.type ==
                                    GadgetType.CIRCLE_ITEMS ||
                                this.widget.type == GadgetType.CATEGORY_BANNER,
                            isProduct: this.widget.type ==
                                GadgetType
                                    .TWO_TO_THREE_PRODUCTS_IN_HORIZONTAL_WITH_TITLE_AS_TEXT,
                            controller: item.controller,
                            image: item.image,
                            onImageChanged: (v) {
                              widget.linkAndImgs[index].image = v;
                              this.widget.onItemListChanged(widget.linkAndImgs);
                            },
                          );
                        },
                      ),
                      SizedBox(height: 14),
                      if (type == GadgetType.BANNER_FOR_MEN_AND_WOMEN)
                        FluentLabeledInput(
                          isEditMode: true,
                          onChanged: widget.onOneImageLinkChanged,
                          label: 'Link',
                          isTapped: false,
                        ),
                      if (expandableTypes.contains(type)) ...[
                        Button(
                          onPressed: () {
                            widget.linkAndImgs.add(
                              GadgetLink(
                                controller: TextEditingController(),
                              ),
                            );
                            this.widget.onItemListChanged(widget.linkAndImgs);
                          },
                          child: Text('Add Card +'),
                        ),
                      ],
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: GadgetReview(
            imgPath: this.widget.type.previewImagePath,
            description: this.widget.type.previewDescription,
          ),
        ),
      ],
    );
  }

  statusAndLocation() {
    return RowOfTwoChildren(
      child1: CustomAutoSuggestedBox(
        items: GadgetStatus.values.map((e) => e.name).toList(),
        onChanged: (v) {
          if (v != null) {
            setState(() {
              status = GadgetStatus.values.firstWhere((el) => v == el.name);
            });
            if (status != null) {
              widget.onStatusChanged.call(status!);
            }
          }
        },
        label: 'Status',
        isEditMode: true,
      ),
      child2: CustomAutoSuggestedBox(
        items: GadgetLocation.values.map((e) => e.name).toList(),
        onChanged: (v) {
          if (v != null) {
            setState(() {
              location = GadgetLocation.values.firstWhere((el) => v == el.name);
            });
            if (location != null) {
              widget.onLocationChanged.call(location!);
            }
          }
        },
        label: 'Location',
        isEditMode: true,
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(withData: true);
      if (result == null) return;
      widget.onTitleImageChanged.call(result);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }
}

class LinkAndImageTile extends StatelessWidget {
  LinkAndImageTile({
    Key? key,
    this.onImageChanged,
    this.image,
    this.isCategory = false,
    this.isProduct = false,
    this.controller,
  }) : super(key: key);

  final TextEditingController? controller;

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
              controller: controller,
              editMode: true,
              validator: emptyField,
              hintText: isCategory
                  ? 'Category Id'
                  : isProduct
                      ? 'Product Id'
                      : 'Link',
              // initialValue: this.widget.link,
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
