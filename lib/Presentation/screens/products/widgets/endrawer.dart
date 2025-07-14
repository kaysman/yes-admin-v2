import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EndDrawer extends StatefulWidget {
  EndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  int selectedIndex = 0;
  int? selectedBrandId;
  int? selectedCategoryId;
  int? selectedGenderId;
  int? selectedSizeId;
  int? selectedmarketId;
  int? selectedColorId;
  int? quantity;

  List<Map<String, dynamic>> quantyties = [
    {"from": 0, "to": 10},
    {"from": 10, "to": 20},
    {"from": 20, "to": 30},
    {"from": 30, "to": 40},
    {"from": 40, "to": 50},
    {"from": 50, "to": 60},
    {"from": 60, "to": 70},
  ];

  late BrandBloc brandBloc;
  late CategoryBloc categoryBloc;
  late MarketBloc marketBloc;
  late FilterBloc filterBloc;
  late ProductBloc productBloc;
  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceTController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productBloc = context.read<ProductBloc>();
    if (productBloc.state.lastFilter != null) {
      selectedBrandId = productBloc.state.lastFilter!.brand_id;
      selectedCategoryId = productBloc.state.lastFilter!.category_id;
      selectedGenderId = productBloc.state.lastFilter!.gender_id;
      selectedSizeId = productBloc.state.lastFilter!.size_id;
      selectedmarketId = productBloc.state.lastFilter!.market_id;
      selectedColorId = productBloc.state.lastFilter!.color_id;
      priceFromController.text =
          productBloc.state.lastFilter!.priceFrom?.toString() ?? '';
      priceTController.text =
          productBloc.state.lastFilter!.priceTo?.toString() ?? '';
      quantity = productBloc.state.lastFilter!.quantity;
    }
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
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: NavigationRail(
                      leading: null,
                      minWidth: 100,
                      backgroundColor: kScaffoldBgColor,
                      onDestinationSelected: (val) => setState(
                        () {
                          selectedIndex = val;
                        },
                      ),
                      destinations: [
                        filterSideBarMenuItem(
                          'Brands',
                          selectedItem: selectedBrandId,
                        ),
                        filterSideBarMenuItem(
                          'Categories',
                          selectedItem: selectedCategoryId,
                        ),
                        filterSideBarMenuItem(
                          'Markets',
                          selectedItem: selectedmarketId,
                        ),
                        filterSideBarMenuItem(
                          'Price',
                          selectedItem: priceFromController,
                        ),
                        filterSideBarMenuItem(
                          'Quantity',
                          selectedItem: quantity,
                        ),
                        filterSideBarMenuItem(
                          'Colors',
                          selectedItem: selectedColorId,
                        ),
                        filterSideBarMenuItem(
                          'Sizes',
                          selectedItem: selectedSizeId,
                        ),
                        filterSideBarMenuItem(
                          'Genders',
                          selectedItem: selectedGenderId,
                        ),
                      ],
                      selectedIndex: selectedIndex,
                    ),
                  ),
                  Expanded(
                    child: buildBody(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: kScaffoldBgColor!, width: 1),
              ),
              color: kWhite,
            ),
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  height: double.infinity,
                  child: TextButton(
                    child: Text(
                      'Close',
                      style: TextStyle(color: kText2Color),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
                VerticalDivider(
                  endIndent: 15,
                  indent: 15,
                  width: 2,
                  color: kScaffoldBgColor,
                  thickness: 1,
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: Builder(
                      builder: (context) {
                        return TextButton(
                          child: Text(
                            'Clear All',
                            style: TextStyle(color: kText2Color),
                          ),
                          onPressed: () {
                            if (productBloc.state.lastFilter != null) {
                              setState(
                                () {
                                  selectedBrandId = null;
                                  selectedCategoryId = null;
                                  selectedGenderId = null;
                                  selectedSizeId = null;
                                  selectedmarketId = null;
                                  selectedColorId = null;
                                  priceFromController.text = '';
                                  priceTController.text = '';
                                  quantity = null;
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
                VerticalDivider(
                  endIndent: 15,
                  indent: 15,
                  width: 2,
                  color: kScaffoldBgColor,
                  thickness: 1,
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: BlocConsumer<ProductBloc, ProductState>(
                      listener: (_, state) {
                        if (state.listingStatus == ProductListStatus.idle) {
                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) {
                        return TextButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Apply',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              if (state.listingStatus ==
                                  ProductListStatus.silentLoading)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                          onPressed: () async {
                            FilterForProductDTO data = FilterForProductDTO(
                              brand_id: selectedBrandId,
                              category_id: selectedCategoryId,
                              color_id: selectedColorId,
                              gender_id: selectedGenderId,
                              market_id: selectedmarketId,
                              priceFrom: int.tryParse(priceFromController.text),
                              priceTo: int.tryParse(priceTController.text),
                              quantity: quantity,
                              size_id: selectedSizeId,
                            );
                            await productBloc.getAllProducts(
                              filter: data,
                              subtle: true,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  NavigationRailDestination filterSideBarMenuItem(
    String title, {
    selectedItem,
  }) {
    return NavigationRailDestination(
      selectedIcon: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        color: kWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () {
                if (productBloc.state.lastFilter != null) {
                  setState(
                    () {
                      if (selectedItem == selectedBrandId) {
                        selectedBrandId = null;
                      } else if (selectedItem == selectedCategoryId) {
                        selectedCategoryId = null;
                      } else if (selectedItem == selectedGenderId) {
                        selectedGenderId = null;
                      } else if (selectedItem == selectedSizeId) {
                        selectedSizeId = null;
                      } else if (selectedItem == selectedmarketId) {
                        selectedmarketId = null;
                      } else if (selectedItem == selectedColorId) {
                        selectedColorId = null;
                      } else if (selectedItem == priceFromController ||
                          selectedItem == priceTController) {
                        priceFromController.text = '';
                        priceTController.text = '';
                      } else if (selectedItem == quantity) {
                        quantity = null;
                      }
                    },
                  );
                }
              },
              child: Text('Clear'),
            )
          ],
        ),
      ),
      icon: Text(title),
      label: Text(title),
    );
  }

  Widget buildBody() {
    switch (selectedIndex) {
      case 0:
        return brandFilterList();
      case 1:
        return categoryFilterList();
      case 2:
        return marketFilterList();
      case 3:
        return priceRangeFilterList();
      case 4:
        return quantityFilterList();
      case 5:
        return colorFilterList();
      case 6:
        return sizeFilterList();
      case 7:
        return genderFilterList();
      default:
        return SizedBox();
    }
  }

  BlocBuilder<MarketBloc, MarketState> marketFilterList() {
    return BlocBuilder<MarketBloc, MarketState>(
        bloc: marketBloc,
        builder: (context, marketState) {
          if (marketState.listingStatus == MarketListStatus.loading) {
            return Container(
              color: kWhite,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            );
          }
          if (marketState.listingStatus == MarketListStatus.error) {
            return Container(
              color: kWhite,
              height: double.infinity,
              child: Center(
                child: Text(
                    'Failed to fetcing orders, please check your Internet Connection and Try again!'),
              ),
            );
          }
          return Container(
            color: kWhite,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                  children: marketState.markets?.map((e) {
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                onTap: () => setState(() {
                                  selectedmarketId = e.id;
                                }),
                                leading: Icon(
                                  Icons.check,
                                  color: e.id == selectedmarketId
                                      ? kPrimaryColor
                                      : kScaffoldBgColor,
                                ),
                                title: Text(
                                  '${e.title}',
                                  style: TextStyle(color: kText2Color),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList() ??
                      []),
            ),
          );
        });
  }

  BlocBuilder<CategoryBloc, CategoryState> categoryFilterList() {
    return BlocBuilder<CategoryBloc, CategoryState>(
        bloc: categoryBloc,
        builder: (context, categoryState) {
          return categoryState.listingStatus == CategoryListStatus.loading
              ? Container(
                  color: kWhite,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                )
              : Container(
                  color: kWhite,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                        children: categoryState.categories?.map((e) {
                              return Card(
                                child: ListTile(
                                  onTap: () => setState(() {
                                    selectedCategoryId = e.id;
                                  }),
                                  leading: Icon(
                                    Icons.check,
                                    color: selectedCategoryId == e.id
                                        ? kPrimaryColor
                                        : kScaffoldBgColor,
                                  ),
                                  title: Text(
                                    '${e.title_tm}',
                                    style: TextStyle(color: kText2Color),
                                  ),
                                ),
                              );
                            }).toList() ??
                            []),
                  ),
                );
        });
  }

  BlocBuilder brandFilterList() {
    return BlocBuilder<BrandBloc, BrandState>(
      bloc: brandBloc,
      builder: (context, brnadState) {
        return brnadState.listingStatus == BrandListStatus.loading
            ? Container(
                color: kWhite,
                child: Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              )
            : Container(
                color: kWhite,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: brnadState.brands?.map(
                          (e) {
                            return Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    onTap: () => setState(() {
                                      selectedBrandId = e.id;
                                    }),
                                    leading: Icon(
                                      Icons.check,
                                      color: selectedBrandId == e.id
                                          ? kPrimaryColor
                                          : kScaffoldBgColor,
                                    ),
                                    title: Text(
                                      '${e.name}',
                                      style: TextStyle(color: kText2Color),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ).toList() ??
                        [],
                  ),
                ),
              );
      },
    );
  }

  Container priceRangeFilterList() {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: [
          LabeledInput(
            editMode: true,
            controller: priceFromController,
            label: 'From',
          ),
          SizedBox(height: 20),
          LabeledInput(
            editMode: true,
            controller: priceTController,
            label: 'TO',
          ),
        ],
      ),
    );
  }

  Container quantityFilterList() {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: quantyties
            .map((e) => Card(
                  child: ListTile(
                    onTap: () => setState(() {
                      quantity = e['to'];
                    }),
                    leading: Icon(
                      Icons.check,
                      color: quantity == e['to']
                          ? kPrimaryColor
                          : kScaffoldBgColor,
                    ),
                    title: Row(
                      children: [
                        Text('${e['from']}'),
                        SizedBox(
                          width: 30,
                          child: Divider(
                            endIndent: 10,
                            indent: 10,
                            height: 1,
                            color: kPrimaryColor,
                            thickness: 1,
                          ),
                        ),
                        Text('${e['to']}'),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  BlocBuilder<FilterBloc, FilterState> colorFilterList() {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, filterState) {
          var colors = filterState.filters
              ?.where((element) => element.type == FilterType.COLOR);
          return filterState.listingStatus == FilterListStatus.loading
              ? Container(
                  color: kWhite,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                )
              : Container(
                  color: kWhite,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                        children: colors?.map((e) {
                              return Column(
                                children: [
                                  Card(
                                    child: ListTile(
                                      onTap: () => setState(() {
                                        selectedColorId = e.id;
                                      }),
                                      leading: Icon(
                                        Icons.check,
                                        color: selectedColorId == e.id
                                            ? kPrimaryColor
                                            : kScaffoldBgColor,
                                      ),
                                      title: Text(
                                        '${e.name_tm}',
                                        style: TextStyle(color: kText2Color),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList() ??
                            []),
                  ),
                );
        });
  }

  BlocBuilder<FilterBloc, FilterState> sizeFilterList() {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, filterState) {
          var sizes = filterState.filters
              ?.where((element) => element.type == FilterType.SIZE);
          return filterState.listingStatus == FilterListStatus.loading
              ? Container(
                  color: kWhite,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                )
              : Container(
                  color: kWhite,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                        children: sizes?.map((e) {
                              return Column(
                                children: [
                                  Card(
                                    child: ListTile(
                                      onTap: () => setState(() {
                                        selectedSizeId = e.id;
                                      }),
                                      leading: Icon(
                                        Icons.check,
                                        color: selectedSizeId == e.id
                                            ? kPrimaryColor
                                            : kScaffoldBgColor,
                                      ),
                                      title: Text(
                                        '${e.name_tm}',
                                        style: TextStyle(color: kText2Color),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList() ??
                            []),
                  ),
                );
        });
  }

  BlocBuilder<FilterBloc, FilterState> genderFilterList() {
    return BlocBuilder<FilterBloc, FilterState>(
        bloc: filterBloc,
        builder: (context, filterState) {
          var genders = filterState.filters
              ?.where((element) => element.type == FilterType.GENDER);
          return filterState.listingStatus == FilterListStatus.loading
              ? Container(
                  color: kWhite,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                )
              : Container(
                  color: kWhite,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                        children: genders?.map((e) {
                              return Column(
                                children: [
                                  Card(
                                    child: ListTile(
                                      onTap: () => setState(() {
                                        selectedGenderId = e.id;
                                      }),
                                      leading: Icon(
                                        Icons.check,
                                        color: selectedGenderId == e.id
                                            ? kPrimaryColor
                                            : kScaffoldBgColor,
                                      ),
                                      title: Text(
                                        '${e.name_tm}',
                                        style: TextStyle(color: kText2Color),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList() ??
                            []),
                  ),
                );
        });
  }
}
