import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/widgets/size-filter-item.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/info.label.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:admin_v2/Presentation/shared/validators.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../markets/bloc/market.bloc.dart';

class ProductUpdateInfo extends StatefulWidget {
  const ProductUpdateInfo({
    Key? key,
    required this.pageController,
    required this.formKey,
    required this.titleController_tm,
    required this.titleController_ru,
    required this.priceController,
    required this.codeController,
    required this.descriptionController_tm,
    required this.descriptionController_ru,
    required this.onColorChanged,
    required this.onSizeChanged,
    required this.onBrandChanged,
    required this.onCategoryChanged,
    required this.onGenderChanged,
    required this.onMarketChanged,
    required this.ourPriceController,
    required this.marketPriceController,
    required this.product,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final PageController pageController;
  final ProductEntity product;
  final TextEditingController titleController_tm;
  final TextEditingController titleController_ru;
  final TextEditingController priceController;
  final TextEditingController codeController;
  final TextEditingController descriptionController_tm;
  final TextEditingController descriptionController_ru;
  final TextEditingController ourPriceController;
  final TextEditingController marketPriceController;
  final ValueChanged<FilterEntity> onColorChanged;
  final ValueChanged<List<SizeEntity>> onSizeChanged;
  final ValueChanged<BrandEntity> onBrandChanged;
  final ValueChanged<CategoryEntity> onCategoryChanged;
  final ValueChanged<FilterEntity> onGenderChanged;
  final ValueChanged<MarketEntity> onMarketChanged;

  @override
  State<ProductUpdateInfo> createState() => _ProductUpdateInfoState();
}

class _ProductUpdateInfoState extends State<ProductUpdateInfo> {
  late FilterBloc filterBloc;
  late CategoryBloc categoryBloc;
  late BrandBloc brandBloc;
  FilterEntity? color;
  FilterEntity? gender;
  FilterEntity? size;
  CategoryEntity? category;
  BrandEntity? brand;
  TextEditingController sizeCountController = TextEditingController();

  List<SizeEntity> _selectedSizes = [];
  MarketEntity? market;

  bool editMode = false;

  @override
  void initState() {
    super.initState();

    color = widget.product.color;
    gender = widget.product.gender;
    _selectedSizes = widget.product.sizes!;
    brand = widget.product.brand;
    market = widget.product.market;
    category = widget.product.category;

    filterBloc = BlocProvider.of<FilterBloc>(context);
    if (filterBloc.state.filters == null) {
      filterBloc.getAllFilters();
    }
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (categoryBloc.state.categories == null) {
      categoryBloc.getAllCategories();
    }
    brandBloc = BlocProvider.of<BrandBloc>(context);
    if (brandBloc.state.brands == null) {
      brandBloc.getAllBrands();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, color: kBlack),
                ),
                Text(
                  "Haryt döret".toUpperCase(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => setState(() => editMode = !editMode),
                  child: Text(
                    editMode ? "Ignore" : "Üýtget",
                    // style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Text(
                  "1/2",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: kText2Color,
                      ),
                ),
              ],
            ),
            SizedBox(height: 20),
            RowOfTwoChildren(
                child1: LabeledInput(
                  hintText: 'Harydyň ady-tm *',
                  validator: emptyField,
                  editMode: editMode,
                  controller: widget.titleController_tm,
                ),
                child2: LabeledInput(
                  editMode: editMode,
                  validator: emptyField,
                  hintText: 'Harydyň ady-ru *',
                  controller: widget.titleController_ru,
                )),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: LabeledInput(
                editMode: editMode,
                hintText: "YES baha *",
                validator: emptyField,
                controller: widget.ourPriceController,
              ),
              child2: LabeledInput(
                editMode: editMode,
                validator: emptyField,
                hintText: "Market baha *",
                controller: widget.marketPriceController,
              ),
            ),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  var sizes = state.filters
                      ?.where(
                        (e) => e.type == FilterType.SIZE,
                      )
                      .toList();
                  var mappedSizes = sizes
                      ?.map((e) => SizeEntity(
                            id: e.id,
                            quantity: e.count,
                            name_ru: e.name_ru,
                            name_tm: e.name_tm,
                          ))
                      .toList();
                  return DropdownSearch<SizeEntity>.multiSelection(
                    enabled: editMode,
                    dropdownBuilder: (context, selectedItems) {
                      return Wrap(
                        children: List.generate(selectedItems.length, (i) {
                          return SizefilterItem(
                            itemForUpdate: selectedItems[i],
                            onCLear: () {
                              setState(() {
                                selectedItems[i].quantity = 1;
                                selectedItems.remove(selectedItems[i]);
                                _selectedSizes.remove(_selectedSizes[i]);
                              });
                            },
                            onChangeCount: (v) {
                              setState(() {
                                selectedItems[i].quantity =
                                    int.tryParse(v ?? '1') ?? 1;
                              });
                            },
                          );
                        }),
                      );
                    },
                    onChanged: (selecteds) {
                      setState(
                        () {
                          _selectedSizes = [];
                          for (var i = 0; i < selecteds.length; i++) {
                            var item = selecteds[i];
                            if (_selectedSizes.contains(item)) {
                              item.quantity =
                                  _selectedSizes[_selectedSizes.indexOf(item)]
                                      .quantity;
                            }
                            _selectedSizes.add(item);
                          }
                        },
                      );
                      print("---------");
                      print(_selectedSizes);
                      print("---------");
                    },
                    validator: (v) => v!.isEmpty ? 'Bos bolmaly dal' : null,
                    selectedItems: _selectedSizes,
                    itemAsString: (v) => v.name_tm ?? '-',
                    items: mappedSizes ?? [],
                    dropdownDecoratorProps: kDropDownDecoratorProps,
                  );
                },
              ),
              child2: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  var genders = state.filters
                      ?.where(
                        (e) => e.type == FilterType.GENDER,
                      )
                      .toList();
                  return InfoWithLabel<FilterEntity>(
                    label: 'Select gender *',
                    editMode: editMode,
                    hintText: 'Select gender *',
                    value: gender,
                    onValueChanged: (v) {
                      widget.onGenderChanged.call(v!);
                      setState(() {
                        gender = v;
                      });
                    },
                    items: genders?.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name_tm ?? ''),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  var categories = state.categories;
                  print(categories);
                  return InfoWithLabel<CategoryEntity>(
                    label: 'Select caategory *',
                    editMode: editMode,
                    hintText: 'Select caategory *',
                    value: category,
                    onValueChanged: (v) {
                      widget.onCategoryChanged.call(v!);
                      setState(() {
                        category = v;
                      });
                    },
                    items: categories?.map(
                      (type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.title_tm ?? ''),
                        );
                      },
                    ).toList(),
                  );
                },
              ),
              child2: BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                  var brands = state.brands;
                  return InfoWithLabel<BrandEntity>(
                    label: 'Select brand *',
                    editMode: editMode,
                    hintText: 'Select brand *',
                    value: brand,
                    onValueChanged: (v) {
                      widget.onBrandChanged.call(v!);
                      setState(() {
                        brand = v;
                      });
                    },
                    items: brands?.map(
                      (type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.name ?? ''),
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ),
            SizedBox(height: 14),
            RowOfTwoChildren(
                child1: BlocBuilder<MarketBloc, MarketState>(
                  builder: (context, state) {
                    var markets = state.markets;
                    return InfoWithLabel<MarketEntity>(
                      label: 'Select market *',
                      editMode: editMode,
                      hintText: 'Select market *',
                      value: market,
                      onValueChanged: (v) {
                        widget.onMarketChanged.call(v!);
                        setState(() {
                          market = v;
                        });
                      },
                      items: markets?.map(
                        (type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.title ?? ''),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
                child2: LabeledInput(
                  editMode: editMode,
                  hintText: "Kody *",
                  validator: emptyField,
                  controller: widget.codeController,
                )),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  var colors = state.filters
                      ?.where(
                        (e) => e.type == FilterType.COLOR,
                      )
                      .toList();
                  return InfoWithLabel<FilterEntity>(
                    label: 'Select color *',
                    editMode: editMode,
                    hintText: 'Select color *',
                    isLoading: state.listingStatus == FilterListStatus.loading,
                    onValueChanged: (v) {
                      widget.onColorChanged.call(v!);
                      setState(() {
                        color = v;
                      });
                    },
                    value: color,
                    items: colors?.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type.name_tm ?? ''),
                          );
                        }).toList() ??
                        [],
                  );
                },
              ),
              child2: LabeledInput(
                editMode: editMode,
                hintText: "Barada-tm",
                controller: widget.descriptionController_tm,
              ),
            ),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: LabeledInput(
                editMode: editMode,
                hintText: "Barada-ru",
                controller: widget.descriptionController_ru,
              ),
              child2: SizedBox(),
            ),
            SizedBox(height: 24),
            Button(
              text: 'Next',
              textColor: kWhite,
              primary: kswPrimaryColor,
              onPressed: () {
                print(_selectedSizes);
                if (widget.formKey.currentState!.validate()) {
                  widget.onSizeChanged.call(_selectedSizes);
                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.decelerate,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
