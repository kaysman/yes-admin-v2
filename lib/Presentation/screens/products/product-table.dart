import 'package:admin_v2/Data/models/product/delete-many-products.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/product/size.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/import.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/screens/products/product-info.dialog.dart';
import 'package:admin_v2/Presentation/screens/products/widgets/endrawer.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/components/scrollable copy.dart';
import 'product-update.dart';

SidebarItem getProductSidebarItem() {
  return SidebarItem(
    logo: SvgPicture.asset(
      'assets/bag.svg',
      width: 30,
      height: 30,
      fit: BoxFit.contain,
      color: kswPrimaryColor,
    ),
    title: "Harytlar",
    view: ProductsTable(),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              BlocConsumer<ProductBloc, ProductState>(
                listener: (_, state) {},
                builder: (context, state) {
                  return SearchFieldInAppBar(
                    hintText: "e.g mb shoes",
                    onEnter: state.listingStatus == ProductListStatus.loading
                        ? null
                        : (value) {
                            print(value);
                            context.read<ProductBloc>().getAllProducts(
                                  filter: FilterForProductDTO(search: value),
                                );
                          },
                  );
                },
              ),
              SizedBox(
                width: 14,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  onSurface: Colors.white,
                  primary: Colors.transparent,
                ),
                onPressed: () {
                  showAppDialog(context, ProductCreateDialog());
                },
                child: Text(
                  'Haryt döret',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ];
    },
  );
}

class ProductsTable extends StatefulWidget {
  const ProductsTable({Key? key}) : super(key: key);

  @override
  State<ProductsTable> createState() => _ProductsTableState();
}

class _ProductsTableState extends State<ProductsTable> {
  int sortColumnIndex = 0;
  int all = 0;
  bool sortAscending = true;
  List<ProductEntity> selectedProducts = [];
  late ProductBloc productBloc;
  List<String> columnNames = [
    'ID',
    'Code',
    'Ady tm',
    'Ady ru',
    'Suraty',
    'Yes Baha',
    'Market Baha',
    'Renki',
    'Jynsy',
    'Mocberi',
    'Brend',
    'Kategoriya',
    'Market',
    'Barada tm',
    'Barada ru',
  ];

  @override
  void initState() {
    productBloc = context.read<ProductBloc>();
    productBloc.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: EndDrawer(),
      body: LayoutBuilder(
        builder: (_, constraints) {
          return BlocBuilder<ProductBloc, ProductState>(
            bloc: productBloc,
            builder: (context, state) {
              var allProductLength = state.totalProductsCount;
              if (state.listingStatus == ProductListStatus.loading) {
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              if (state.listingStatus == ProductListStatus.error) {
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  alignment: Alignment.center,
                  child: TryAgainButton(
                    tryAgain: () async {
                      await productBloc.getAllProducts();
                    },
                  ),
                );
              }
              return Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Text("$allProductLength total products"),
                            Spacer(),
                            if (selectedProducts.length == 1) ...[
                              Button(
                                text: 'Haryt barada',
                                primary: kswPrimaryColor,
                                textColor: kWhite,
                                onPressed: () async {
                                  await showAppDialog(
                                    context,
                                    ProductInfo(
                                      selectedProductId:
                                          selectedProducts.first.id,
                                    ),
                                  );
                                  setState(() {
                                    selectedProducts = [];
                                  });
                                },
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Button(
                                text: 'Uytget',
                                primary: kswPrimaryColor,
                                textColor: kWhite,
                                onPressed: () async {
                                  await showAppDialog(
                                      context,
                                      ProductUpdateDialog(
                                          product: selectedProducts.first));
                                  setState(
                                    () {
                                      selectedProducts = [];
                                    },
                                  );
                                },
                              ),
                            ],
                            if (selectedProducts.length >= 2) ...[
                              Button(
                                text: 'Delete',
                                textColor: Colors.redAccent,
                                borderColor: Colors.redAccent,
                                hasBorder: true,
                                onPressed: () async {
                                  List<int> ids = [];
                                  for (var item in selectedProducts) {
                                    if (item.id != null) {
                                      var id = item.id;
                                      ids.add(id!);
                                    }
                                  }
                                  await showAppDialog(
                                    context,
                                    MultiDeleteProductDialog(
                                      ids: ids,
                                    ),
                                  );
                                  setState(() {
                                    selectedProducts = [];
                                  });
                                },
                              )
                            ],
                            SizedBox(width: 16),
                            OutlinedButton.icon(
                              label: Text(
                                'Import',
                                style: TextStyle(
                                  letterSpacing: .7,
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                showAppDialog(context, ImportDialog());
                              },
                              icon: Icon(
                                Icons.file_upload,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 16),
                            OutlinedButton.icon(
                              label: Text(
                                'Filter',
                                style:
                                    TextStyle(letterSpacing: .7, fontSize: 16),
                              ),
                              onPressed: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              icon: Icon(
                                Icons.filter_list_alt,
                                size: 20,
                                color: state.lastFilter
                                            ?.filterArgumentsIsNotNull ??
                                        false
                                    ? Colors.orange
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ScrollableWidget(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints.maxWidth,
                          ),
                          child: DataTable(
                            border: TableBorder.all(
                              width: 1.0,
                              color: Colors.grey.shade100,
                            ),
                            sortColumnIndex: sortColumnIndex,
                            sortAscending: sortAscending,
                            columns: tableColumns,
                            rows: tableRows(state),
                          ),
                        ),
                      ),
                      Pagination(
                        text: "${state.lastFilter?.take} items per page",
                        goPrevious: state.itemIds.isNotEmpty
                            ? state.itemIds.first.firstId !=
                                    state.currentPage?.firstId
                                ? () async {
                                    productBloc.getAllProducts(
                                      filter: FilterForProductDTO(next: false),
                                    );
                                  }
                                : null
                            : null,
                        goNext: state.currentPage?.firstId ==
                                state.currentPage?.lastId
                            ? null
                            : () async {
                                productBloc.getAllProducts(
                                  filter: FilterForProductDTO(next: true),
                                );
                              },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  get tableColumns {
    return List.generate(columnNames.length, (index) {
      var name = columnNames[index];
      return DataColumn(
        label: Text(name, style: Theme.of(context).textTheme.bodyText1),
      );
    });
  }

  List<DataRow> tableRows(ProductState state) {
    if (state.products == null) return [];

    return List.generate(
      state.products?.length ?? 0,
      (index) {
        var product = state.products?[index];
        var productQuantity = getSum(product?.sizes);
        return DataRow(
          selected: selectedProducts.contains(product),
          onSelectChanged: (v) {
            setState(() {
              if (product != null) {
                if (!selectedProducts.contains(product)) {
                  selectedProducts.add(product);
                } else {
                  selectedProducts.remove(product);
                }
              }
            });
          },
          cells: [
            DataCell(Text("${product?.id ?? '-'}")),
            DataCell(Text("${product?.code ?? '-'}")),
            DataCell(Text("${product?.name_tm ?? '-'} ")),
            DataCell(Text("${product?.name_ru ?? '-'}")),
            DataCell(
              Wrap(
                children: product?.images == null
                    ? []
                    : product?.images!
                            .map(
                              (e) => e.getFullPathImage == null
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundColor: kswPrimaryColor,
                                    )
                                  : CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          Image.network(e.getFullPathImage!)
                                              .image,
                                    ),
                            )
                            .toList() ??
                        [],
              ),
            ),
            DataCell(Text("${product?.ourPrice ?? '-'}")),
            DataCell(Text("${product?.marketPrice ?? '-'}")),
            DataCell(Text("${product?.color?.name_tm ?? '-'}")),
            DataCell(Text("${product?.gender?.name_tm ?? '-'}")),
            DataCell(Text("${productQuantity ?? '-'}")),
            DataCell(Text("${product?.brand?.name ?? '-'}")),
            DataCell(Text("${product?.category?.title_tm ?? '-'}")),
            DataCell(Text("${product?.market?.title ?? '-'}")),
            DataCell(Text("${product?.description_tm ?? '-'}")),
            DataCell(Text("${product?.description_ru ?? '-'}")),
          ],
        );
      },
    );
  }

  int? getSum(List<SizeEntity>? sizes) {
    List<int> my = [];
    if (sizes != null && sizes.isNotEmpty) {
      for (var size in sizes) {
        my.add(size.quantity!);
      }
      var sum = my.reduce((a, b) => a + b);
      return sum;
    }

    return null;
  }
}

class MultiDeleteProductDialog extends StatelessWidget {
  const MultiDeleteProductDialog({
    Key? key,
    required this.ids,
  }) : super(key: key);

  final List<int> ids;

  @override
  Widget build(BuildContext context) {
    print(ids);
    return BlocConsumer<ProductBloc, ProductState>(
      listenWhen: (p, c) => p.multiDeleteStatus != c.multiDeleteStatus,
      listener: (context, state) {
        if (state.multiDeleteStatus == ProductMultiDeleteStatus.success) {
          showSnackBar(
            context,
            Text('Deleted all products successfully'),
            type: SnackbarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * .3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hakykatdan - da saylan harytlarynyzy \' DELETE \' etmek isleyarsinizmi ?',
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    text: 'Yok',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    hasBorder: true,
                    borderColor: kGrey5Color,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Button(
                    text: 'Hawwa',
                    isLoading: state.multiDeleteStatus ==
                        ProductMultiDeleteStatus.loading,
                    primary: kswPrimaryColor,
                    textColor: kWhite,
                    onPressed: () async {
                      DeleteMultiProductModel data =
                          DeleteMultiProductModel(ids: ids);
                      await context
                          .read<ProductBloc>()
                          .multiDeleteProduct(data);
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
