import 'dart:ui';

import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/sub.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/custom-auto-suggested-box.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/fluent-labeled-input.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/widgets/size-filter-item.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/row_2_children.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
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
  final ValueChanged<SubItem> onCategoryChanged;
  final ValueChanged<FilterEntity> onGenderChanged;
  final ValueChanged<MarketEntity> onMarketChanged;

  @override
  State<ProductCerateInfo> createState() => _ProductCerateInfoState();
}

class _ProductCerateInfoState extends State<ProductCerateInfo> {
  late FilterBloc filterBloc;
  f.TextEditingController genderController = f.TextEditingController();
  late CategoryBloc categoryBloc;
  late BrandBloc brandBloc;
  String color = '';
  String gender = '';
  String size = '';
  String category = '';
  String brand = '';
  String market = '';

  bool isNext = false;

  List<FilterEntity> _selectedSizes = [];

  bool hasNode = false;

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
      child: f.Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              f.GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, color: kBlack),
              ),
              Text(
                "Haryt döret".toUpperCase(),
                style: f.FluentTheme.of(context).typography.title?.copyWith(
                      color: kText1Color,
                      fontSize: 24,
                    ),
              ),
              Text(
                "1/2",
                style: f.FluentTheme.of(context).typography.caption?.copyWith(
                      color: kText2Color,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
          SizedBox(height: 20),
          RowOfTwoChildren(
            child1: FluentLabeledInput(
              controller: widget.titleController_tm,
              isEditMode: true,
              isTapped: isNext,
              label: 'Harydyň ady-tm *',
            ),
            child2: FluentLabeledInput(
              controller: widget.titleController_ru,
              isEditMode: true,
              isTapped: isNext,
              label: 'Harydyň ady-ru *',
            ),
          ),
          SizedBox(height: 14),
          RowOfTwoChildren(
            child1: FluentLabeledInput(
              controller: widget.ourPriceController,
              isEditMode: true,
              isTapped: isNext,
              label: 'YES baha *',
            ),
            child2: FluentLabeledInput(
              controller: widget.marketPriceController,
              isEditMode: true,
              isTapped: isNext,
              label: 'Market baha *',
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
                return f.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select sizes *',
                      style:
                          f.FluentTheme.of(context).typography.body?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: kGrey1Color,
                                fontSize: 18,
                              ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DropdownSearch<FilterEntity>.multiSelection(
                      dropdownBuilder: (context, selectedItems) {
                        return f.Wrap(
                          runSpacing: 2,
                          spacing: 2,
                          children: List.generate(selectedItems.length, (i) {
                            return SizefilterItem(
                              item: selectedItems[i],
                              onCLear: () {
                                setState(() {
                                  selectedItems[i].count = 1;
                                  selectedItems.remove(selectedItems[i]);
                                  _selectedSizes.remove(_selectedSizes[i]);
                                });
                              },
                              onChangeCount: (v) {
                                setState(() {
                                  selectedItems[i].count =
                                      int.tryParse(v ?? '1') ?? 1;
                                  _selectedSizes[i].count =
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
                                item.count =
                                    _selectedSizes[_selectedSizes.indexOf(item)]
                                        .count;
                              }
                              _selectedSizes.add(item);
                            }
                          },
                        );
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

                return CustomAutoSuggestedBox(
                  isEditMode: true,
                  label: 'Select gender *',
                  items: genders?.map((e) => e.name_tm ?? '-').toList() ?? [],
                  onChanged: (v) {
                    var mappedGenders =
                        genders?.where((el) => el.name_tm == v).toList();
                    if (mappedGenders?.isNotEmpty == true) {
                      setState(() {
                        gender = v ?? '';
                      });
                      if (mappedGenders != null) {
                        widget.onGenderChanged.call(mappedGenders.first);
                      }
                    }
                  },
                  isTapped: isNext,
                );
              },
            ),
          ),
          SizedBox(height: 14),
          RowOfTwoChildren(
            child1: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                var categories = state.categories;

                var subs = getSubs(categories);

                return CustomAutoSuggestedBox(
                  isEditMode: true,
                  label: 'Select category *',
                  items: subs
                      .map((e) =>
                          '${e.name ?? '-'}     main: ${e.parentName ?? '-'}')
                      .toList(),
                  onChanged: (v) {
                    var filteredCategories = subs
                        .where((el) => v?.contains(el.name!) == true)
                        .toList();
                    if (filteredCategories.isNotEmpty) {
                      setState(() {
                        category = v ?? '';
                      });
                      widget.onCategoryChanged.call(filteredCategories.first);
                    }
                  },
                  isTapped: isNext,
                );
              },
            ),
            child2: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                var brands = state.brands;
                return CustomAutoSuggestedBox(
                  isEditMode: true,
                  label: 'Select brand *',
                  items: brands?.map((e) => '${e.name ?? '-'}').toList() ?? [],
                  onChanged: (v) {
                    var filteredBrands =
                        brands?.where((el) => el.name == v).toList();
                    if (filteredBrands?.isNotEmpty == true) {
                      setState(() {
                        brand = v ?? '';
                      });
                      if (filteredBrands != null) {
                        widget.onBrandChanged.call(filteredBrands.first);
                      }
                    }
                  },
                  isTapped: isNext,
                );
              },
            ),
          ),
          SizedBox(height: 14),
          RowOfTwoChildren(
            child1: BlocBuilder<MarketBloc, MarketState>(
              builder: (context, state) {
                var markets = state.markets;
                return CustomAutoSuggestedBox(
                  isEditMode: true,
                  label: 'Select market *',
                  items:
                      markets?.map((e) => '${e.title ?? '-'}').toList() ?? [],
                  onChanged: (v) {
                    var filteredMarkets =
                        markets?.where((el) => el.title == v).toList();
                    if (filteredMarkets?.isNotEmpty == true) {
                      setState(() {
                        market = v ?? '';
                      });
                      if (filteredMarkets != null) {
                        widget.onMarketChanged.call(filteredMarkets.first);
                      }
                    }
                  },
                  isTapped: isNext,
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
                return CustomAutoSuggestedBox(
                  isEditMode: true,
                  label: 'Select color *',
                  items:
                      colors?.map((e) => '${e.name_tm ?? '-'}').toList() ?? [],
                  onChanged: (v) {
                    var filteredColors =
                        colors?.where((el) => el.name_tm == v).toList();
                    if (filteredColors?.isNotEmpty == true) {
                      setState(() {
                        color = v ?? '';
                      });
                      if (filteredColors != null) {
                        widget.onColorChanged.call(filteredColors.first);
                      }
                    }
                  },
                  isTapped: isNext,
                );
              },
            ),
          ),
          SizedBox(height: 14),
          RowOfTwoChildren(
            child1: FluentLabeledInput(
              controller: widget.descriptionController_tm,
              isEditMode: true,
              isTapped: isNext,
              label: 'Barada-tm',
            ),
            child2: FluentLabeledInput(
              controller: widget.codeController,
              isEditMode: true,
              isTapped: isNext,
              label: 'Kody',
            ),
          ),
          SizedBox(height: 14),
          RowOfTwoChildren(
            child1: FluentLabeledInput(
              controller: widget.descriptionController_ru,
              isEditMode: true,
              isTapped: isNext,
              label: 'Barada-ru',
            ),
            child2: SizedBox(),
          ),
          SizedBox(height: 24),
          Button(
            text: 'Next',
            textColor: kWhite,
            primary: kswPrimaryColor,
            onPressed: () {
              setState(() {
                isNext = true;
              });
              if (widget.formKey.currentState!.validate() && isValidate()) {
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
    );
  }

  bool isValidate() {
    if (widget.codeController.text.isNotEmpty &&
        widget.titleController_tm.text.isNotEmpty &&
        widget.titleController_ru.text.isNotEmpty &&
        widget.ourPriceController.text.isNotEmpty &&
        widget.marketPriceController.text.isNotEmpty &&
        color.isNotEmpty &&
        brand.isNotEmpty &&
        market.isNotEmpty &&
        gender.isNotEmpty &&
        category.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

}

  List<SubItem> getSubs(List<CategoryEntity>? main) {
    List<SubItem> subs = [];
    if (main != null) {
      for (var element in main) {
        subs.addAll(
          element.subcategories?.map(
                (e) {
                  return SubItem(e.id!, e.title_tm, element.title_tm);
                },
              ) ??
              [],
        );
      }
    }
    return subs;
  }