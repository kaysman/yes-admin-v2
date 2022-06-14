import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/scrollable copy.dart';
import 'product-update.dart';

SidebarItem getProductSidebarItem() {
  return SidebarItem(
    title: "Harytlar",
    view: ProductsTable(),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              onSurface: Colors.white,
              primary: Colors.transparent,
            ),
            onPressed: () {
              showAppDialog(context, CreateProductPage());
            },
            child: Text(
              'Haryt döret',
              style: TextStyle(color: Colors.white),
            ),
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
  bool sortAscending = true;
  List<ProductEntity> selectedProducts = [];
  late ProductBloc productBloc;
  List<String> columnNames = [
    'ID',
    'Code',
    'Ady tm',
    'Ady ru',
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
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<ProductBloc, ProductState>(
          bloc: productBloc,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // StatisticsCard(
                  //   label: "Jemi",
                  //   content: "60",
                  //   description: "Market",
                  // ),
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
                  // Pagination(
                  //   goPrevious: () {},
                  //   goNext: () {},
                  //   metaData: Meta(
                  //     totalItems: 50,
                  //     totalPages: 5,
                  //     itemCount: 10,
                  //     currentPage: 1,
                  //   ),
                  // ),
                ],
              ),
            );
          });
    });
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
      state.products!.length,
      (index) {
        var product = state.products![index];
        return DataRow(
          selected: selectedProducts.contains(product),
          onLongPress: () {
            showAppDialog(
              context,
              UpdateProductPage(product: product),
            );
          },
          onSelectChanged: (v) {
            setState(() {
              selectedProducts.add(product);
            });
          },
          cells: [
            DataCell(Text("${product.id}")),
            DataCell(Text("${product.code}")),
            DataCell(Text("${product.name_tm}")),
            DataCell(Text("${product.name_ru}")),
            DataCell(Text("${product.ourPrice}")),
            DataCell(Text("${product.marketPrice}")),
            DataCell(Text("${product.color_id}")),
            DataCell(Text("${product.gender_id}")),
            DataCell(Text("${product.quantity}")),
            DataCell(Text("${product.brand_id}")),
            DataCell(Text("${product.category_id}")),
            DataCell(Text("${product.market_id}")),
            DataCell(Text("${product.description_tm}")),
            DataCell(Text("${product.description_ru}")),
          ],
        );
      },
    );
  }
}
