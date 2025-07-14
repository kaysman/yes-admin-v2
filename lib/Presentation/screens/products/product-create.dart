import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/category/sub.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/product/create-product.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-create-info.dialog.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-pick-image.dialog.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/models/filter/size.dart';

class ProductCreateDialog extends StatefulWidget {
  ProductCreateDialog({Key? key}) : super(key: key);

  @override
  State<ProductCreateDialog> createState() => _ProductCreateDialogState();
}

class _ProductCreateDialogState extends State<ProductCreateDialog> {
  late ProductBloc productBloc;
  late BrandBloc brandBloc;
  late CategoryBloc categoryBloc;
  late MarketBloc marketBloc;
  late FilterBloc filterBloc;
  GlobalKey<FormState> productCreateFormKey = GlobalKey<FormState>();
  List<PlatformFile> _selectedImages = [];
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
  SubItem? category;
  BrandEntity? brand;
  MarketEntity? market;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);

    titleController_tm.text = 'awd';
    titleController_ru.text = 'asc';
    priceController.text = '2134';
    codeController.text = 'wd';
    descriptionController_tm.text = 'wdw';
    ourPriceController.text = '324';
    marketPriceController.text = '123';
    descriptionController_ru.text = 'adawd';
    brandBloc = context.read<BrandBloc>();
    if (brandBloc.state.brands == null) {
      brandBloc.getAllBrands();
    }
    categoryBloc = context.read<CategoryBloc>();
    if (categoryBloc.state.categories == null) {
      categoryBloc.getAllCategories();
    }

    marketBloc = context.read<MarketBloc>();
    if (marketBloc.state.markets == null) {
      marketBloc.getAllMarkets();
    }

    filterBloc = context.read<FilterBloc>();
    if (filterBloc.state.filters == null) {
      filterBloc.getAllFilters();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (s1, s2) => s1.createStatus != s2.createStatus,
      listener: (context, state) {
        if (state.createStatus == ProductCreateStatus.success) {
          showSnackbar(
            context,
            Snackbar(
              content: Text('Created successfully'),
            ),
          );
          Navigator.of(context).pop();
        } else if (state.createStatus == ProductCreateStatus.error) {
          showSnackbar(
            context,
            Snackbar(
              content: Text(
                'Creation error. Please, try again!',
                style: FluentTheme.of(context).typography.body?.copyWith(
                      color: Colors.red,
                    ),
              ),
            ),
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * .45,
            child: ExpandablePageView(
              controller: _pageViewController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ProductCerateInfo(
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
                      category = v;
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
                          .map((e) => CreateSizeDTO(
                                size_id: e.id!,
                                count: e.count,
                              ))
                          .toList();
                    });
                  },
                  onGenderChanged: (v) {
                    setState(() {
                      gender = v;
                    });
                  },
                ),
                ProductPickIMages(
                  onSelectedIMages: (v) {
                    setState(() {
                      _selectedImages = v.files;
                    });
                  },
                  onSave: onSave,
                  pageController: _pageViewController,
                  saveLoading:
                      state.createStatus == ProductCreateStatus.loading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onSave() {
    CreateProductDTO _data = CreateProductDTO(
      name_tm: titleController_tm.text,
      name_ru: titleController_ru.text,
      ourPrice: int.parse(ourPriceController.text),
      marketPrice: int.parse(marketPriceController.text),
      color_id: color!.id!,
      gender_id: gender!.id!,
      code: codeController.text,
      brand_id: brand!.id,
      category_id: category!.id,
      market_id: market!.id!,
      description_ru: descriptionController_ru.text,
      description_tm: descriptionController_tm.text,
      sizes: sizes,
    );
    if (_selectedImages.isNotEmpty) {
      // print('Saylanan suart: ${_selectedImages.first.files.length}');
      productBloc.createProduct(_selectedImages, _data.toJson());
    }
  }
}
