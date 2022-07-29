import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
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

class ProductCerateInfo extends StatefulWidget {
  const ProductCerateInfo(
      {Key? key,
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
      required this.marketPriceController})
      : super(key: key);
  final GlobalKey<FormState> formKey;
  final PageController pageController;
  final TextEditingController titleController_tm;
  final TextEditingController titleController_ru;
  final TextEditingController priceController;
  final TextEditingController codeController;
  final TextEditingController descriptionController_tm;
  final TextEditingController descriptionController_ru;
  final TextEditingController ourPriceController;
  final TextEditingController marketPriceController;
  final ValueChanged<FilterEntity> onColorChanged;
  final ValueChanged<List<FilterEntity>> onSizeChanged;
  final ValueChanged<BrandEntity> onBrandChanged;
  final ValueChanged<CategoryEntity> onCategoryChanged;
  final ValueChanged<FilterEntity> onGenderChanged;
  final ValueChanged<MarketEntity> onMarketChanged;

  @override
  State<ProductCerateInfo> createState() => _ProductCerateInfoState();
}

class _ProductCerateInfoState extends State<ProductCerateInfo> {
  late FilterBloc filterBloc;
  late CategoryBloc categoryBloc;
  late BrandBloc brandBloc;
  FilterEntity? color;
  FilterEntity? gender;
  FilterEntity? size;
  CategoryEntity? category;
  BrandEntity? brand;

  List<FilterEntity> _selectedSizes = [];
  MarketEntity? market;

  @override
  void initState() {
    super.initState();
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
                  editMode: true,
                  controller: widget.titleController_tm,
                ),
                child2: LabeledInput(
                  editMode: true,
                  validator: emptyField,
                  label: 'Harydyň ady-ru *',
                  hintText: 'Harydyň ady-ru *',
                  controller: widget.titleController_ru,
                )),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: LabeledInput(
                editMode: true,
                hintText: "YES baha *",
                validator: emptyField,
                controller: widget.ourPriceController,
              ),
              child2: LabeledInput(
                editMode: true,
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select sizes *',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: kGrey1Color,
                            ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DropdownSearch<FilterEntity>.multiSelection(
                        dropdownBuilder: (context, selectedItems) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: Wrap(
                              children:
                                  List.generate(selectedItems.length, (i) {
                                return SizefilterItem(
                                  item: selectedItems[i],
                                  onCLear: () {
                                    setState(() {
                                      selectedItems[i].count = 1;
                                      selectedItems.remove(selectedItems[i]);
                                      _selectedSizes.remove(_selectedSizes[i]);
                                      // print('------onCelear------');
                                      // print(_selectedSizes);
                                      // print('------onCelear------');
                                    });
                                  },
                                  onChangeCount: (v) {
                                    setState(() {
                                      selectedItems[i].count =
                                          int.tryParse(v ?? '1') ?? 1;
                                      _selectedSizes[i].count =
                                          int.tryParse(v ?? '1') ?? 1;

                                      // print('------onChangeCount------');
                                      // print(_selectedSizes);
                                      // print('------onChangeCount------');
                                    });
                                  },
                                );
                              }),
                            ),
                          );
                        },
                        onChanged: (selecteds) {
                          setState(
                            () {
                              _selectedSizes = [];
                              for (var i = 0; i < selecteds.length; i++) {
                                var item = selecteds[i];
                                if (_selectedSizes.contains(item)) {
                                  item.count = _selectedSizes[
                                          _selectedSizes.indexOf(item)]
                                      .count;
                                }
                                _selectedSizes.add(item);
                              }
                            },
                          );
                          // print("---------");
                          // print(_selectedSizes);
                          // print("---------");
                        },
                        validator: (v) => v!.isEmpty ? 'Bos bolmaly dal' : null,
                        selectedItems: _selectedSizes,
                        itemAsString: (v) => v.name_tm ?? '',
                        items: sizes ?? [],
                        dropdownDecoratorProps: kDropDownDecoratorProps,
                      ),
                    ],
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
                    editMode: true,
                    validator: notSelectedItem,
                    hintText: 'Select gender *',
                    isLoading: state.listingStatus == FilterListStatus.loading,
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
                  return InfoWithLabel<CategoryEntity>(
                    label: 'Select caategory *',
                    editMode: true,
                    validator: notSelectedItem,
                    hintText: 'Select caategory *',
                    isLoading:
                        state.listingStatus == CategoryListStatus.loading,
                    value: category,
                    onValueChanged: (v) {
                      widget.onCategoryChanged.call(v!);
                      setState(() {
                        category = v;
                      });
                    },
                    items: categories?.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.title_tm ?? ''),
                      );
                    }).toList(),
                  );
                },
              ),
              child2: BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                  var brands = state.brands;
                  return InfoWithLabel<BrandEntity>(
                    label: 'Select brand *',
                    editMode: true,
                    hintText: 'Select brand *',
                    isLoading: state.listingStatus == BrandListStatus.loading,
                    validator: notSelectedItem,
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
                    editMode: true,
                    validator: notSelectedItem,
                    hintText: 'Select market *',
                    isLoading: state.listingStatus == MarketListStatus.loading,
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
              child2: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  var colors = state.filters
                      ?.where(
                        (e) => e.type == FilterType.COLOR,
                      )
                      .toList();
                  return InfoWithLabel<FilterEntity>(
                    label: 'Select color *',
                    editMode: true,
                    validator: notSelectedItem,
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
            ),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: LabeledInput(
                editMode: true,
                hintText: "Barada-tm",
                controller: widget.descriptionController_tm,
              ),
              child2: LabeledInput(
                editMode: true,
                hintText: "Kody *",
                validator: emptyField,
                controller: widget.codeController,
              ),
            ),
            SizedBox(height: 14),
            RowOfTwoChildren(
              child1: LabeledInput(
                editMode: true,
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
