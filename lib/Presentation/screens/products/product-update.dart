import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/product/update-product.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-update-img.dialog.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-update-info.dialog.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/models/filter/size.dart';

class ProductUpdateDialog extends StatefulWidget {
  ProductUpdateDialog({Key? key, required this.product}) : super(key: key);

  final ProductEntity product;
  @override
  State<ProductUpdateDialog> createState() => _ProductUpdateDialogState();
}

class _ProductUpdateDialogState extends State<ProductUpdateDialog> {
  late ProductBloc productBloc;
  late BrandBloc brandBloc;
  late CategoryBloc categoryBloc;
  late MarketBloc marketBloc;
  late FilterBloc filterBloc;
  GlobalKey<FormState> productCreateFormKey = GlobalKey<FormState>();
  List<FilePickerResult> _selectedImages = [];
  final _pageViewController = PageController();
  bool saveLoading = false;
  final titleController_tm = TextEditingController();
  final titleController_ru = TextEditingController();
  final priceController = TextEditingController();
  final codeController = TextEditingController();
  final descriptionController_tm = TextEditingController();
  final ourPriceController = TextEditingController();
  final marketPriceController = TextEditingController();
  final descriptionController_ru = TextEditingController();
  FilterEntity? color;
  FilterEntity? gender;
  List<CreateSizeDTO> sizes = [];
  CategoryEntity? category;
  BrandEntity? brand;
  MarketEntity? market;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);

    titleController_tm.text = widget.product.name_tm ?? '-';
    titleController_ru.text = widget.product.name_ru ?? '-';
    codeController.text = widget.product.code ?? '-';
    descriptionController_tm.text = widget.product.description_tm ?? '-';
    descriptionController_ru.text = widget.product.description_ru ?? '-';
    ourPriceController.text = widget.product.ourPrice.toString();
    marketPriceController.text = widget.product.marketPrice.toString();
    brandBloc = context.read<BrandBloc>();
    if (brandBloc.state.brands == null) {
      brandBloc.getAllBrands();
    }
    categoryBloc = context.read<CategoryBloc>();
    if (brandBloc.state.brands == null) {
      categoryBloc.getAllCategories();
    }

    marketBloc = context.read<MarketBloc>();
    if (brandBloc.state.brands == null) {
      marketBloc.getAllMarkets();
    }

    filterBloc = context.read<FilterBloc>();
    if (brandBloc.state.brands == null) {
      filterBloc.getAllFilters();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  String? get oldNameTm => widget.product.name_tm;
  String? get oldNameRu => widget.product.name_ru;
  String? get oldCode => widget.product.code;
  String? get oldDescriptionTm => widget.product.description_tm;
  String? get oldDescriptionRu => widget.product.description_ru;
  int? get oldOurPrice => widget.product.ourPrice;
  int? get oldMarketPrice => widget.product.marketPrice;
  int? get oldBrandID => widget.product.brand?.id;
  int? get oldMarketID => widget.product.market?.id;
  int? get oldCategoryID => widget.product.category?.id;
  int? get oldColorID => widget.product.color?.id;
  int? get oldGenderID => widget.product.gender?.id;
  List<CreateSizeDTO>? get oldSizes => widget.product.sizes
      ?.map(
        (e) => CreateSizeDTO(size_id: e.id, count: e.quantity),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (s1, s2) =>
          s1.deleteStatus != s2.deleteStatus ||
          s1.updateStatus != s2.updateStatus,
      listener: (context, state) {
        if (state.deleteStatus == ProductDeleteStatus.success) {
          Navigator.of(context).pop();
          showSnackBar(
            context,
            Text('Deleted successfully'),
            type: SnackbarType.success,
          );
        } else if (state.updateStatus == ProductUpdateStatus.success) {
          Navigator.of(context).pop();
          showSnackBar(
            context,
            Text('Updated successfully'),
            type: SnackbarType.success,
          );
        }
      },
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width * .45,
          child: ExpandablePageView(
            controller: _pageViewController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ProductUpdateInfo(
                product: widget.product,
                marketPriceController: marketPriceController,
                ourPriceController: ourPriceController,
                descriptionController_ru: descriptionController_ru,
                descriptionController_tm: descriptionController_tm,
                priceController: priceController,
                titleController_ru: titleController_ru,
                titleController_tm: titleController_tm,
                pageController: _pageViewController,
                formKey: productCreateFormKey,
                codeController: codeController,
                onBrandChanged: (v) {
                  setState(() {
                    brand = v;
                  });
                },
                onMarketChanged: (v) {
                  setState(() {
                    market = v;
                  });
                },
                onCategoryChanged: (v) {
                  setState(() {
                    category = CategoryEntity(
                      id: v.id,
                      title_tm: v.name,
                    );
                  });
                },
                onColorChanged: (v) {
                  setState(() {
                    color = v;
                  });
                },
                onSizeChanged: (v) {
                  setState(() {
                    sizes = v
                        .map(
                          (e) => CreateSizeDTO(
                            size_id: e.id,
                            count: e.quantity,
                          ),
                        )
                        .toList();
                  });
                },
                onGenderChanged: (v) {
                  setState(() {
                    gender = v;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  onSave() async {
    UpdateProductDTO _data = UpdateProductDTO(
      id: widget.product.id!,
      name_tm: checkIfChangedAndReturn(oldNameTm, titleController_tm.text),
      name_ru: checkIfChangedAndReturn(oldNameRu, titleController_ru.text),
      ourPrice: checkIfChangedAndReturn(
          oldOurPrice, int.parse(ourPriceController.text)),
      marketPrice: checkIfChangedAndReturn(
        oldMarketPrice,
        int.parse(marketPriceController.text),
      ),
      color_id: checkIfChangedAndReturn(oldColorID, color?.id!),
      gender_id: checkIfChangedAndReturn(oldGenderID, gender?.id!),
      code: checkIfChangedAndReturn(oldCode, codeController.text),
      brand_id: checkIfChangedAndReturn(oldBrandID, brand?.id),
      category_id: checkIfChangedAndReturn(oldCategoryID, category?.id!),
      market_id: checkIfChangedAndReturn(oldMarketID, market?.id!),
      description_ru: checkIfChangedAndReturn(
          oldDescriptionRu, descriptionController_ru.text),
      description_tm: checkIfChangedAndReturn(
        oldDescriptionTm,
        descriptionController_tm.text,
      ),
      sizes: checkIfChangedAndReturn(oldSizes, sizes),
    );
    // print(_data.toJson());
    // if (_selectedImages.isNotEmpty) {
    // print(_selectedImages.first);
    await productBloc.updateProduct(_data);
    // }
  }
}
