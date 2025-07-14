import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/order/order.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/emty-product-view.dart';
import 'package:admin_v2/Presentation/screens/orders/order.bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart' as fl;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/button.dart' as fb;

SidebarItem getOrdersSideBarItem() {
  return SidebarItem(
    logo: Image.asset(
      'assets/category.png',
      width: 30,
      height: 30,
      color: kswPrimaryColor,
    ),
    title: "Zakazlar",
    view: OrdersTable(),
    getActions: (context) {
      return [
        // Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Row(
        //     children: [
        //       BlocConsumer<OrderBloc, OrderState>(
        //         listener: (_, state) {},
        //         builder: (context, state) {
        //           return SearchFieldInAppBar(
        //             hintText: "e.g mb orders",
        //             onEnter: state.listingStatus == OrderListStatus.loading
        //                 ? null
        //                 : (value) {
        //                     print(value);
        //                     context.read<OrderBloc>().getAllOrders(
        //                           filter: PaginationDTO(search: value),
        //                         );
        //                   },
        //           );
        //         },
        //       ),
        //       SizedBox(
        //         width: 14,
        //       ),
        //       // OutlinedButton(
        //       //   style: OutlinedButton.styleFrom(
        //       //     onSurface: Colors.white,
        //       //     primary: Colors.transparent,
        //       //   ),
        //       //   onPressed: () {
        //       //     showAppDialog(context, CreateCategoryPage());
        //       //   },
        //       //   child: Text(
        //       //     'Kategoriya döret',
        //       //     style: TextStyle(color: Colors.white),
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
      ];
    },
  );
}

class OrdersTable extends StatefulWidget {
  const OrdersTable({Key? key, this.emptyOrderText}) : super(key: key);
  final String? emptyOrderText;

  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  List<OrderEntity> selectedOrders = [];
  late OrderBloc orderBloc;
  List<String> columnNames = [
    'ID',
    'Status',
    'Adressi',
    'Bellik',
    'Harytlaryn id-lary',
  ];

  // @override
  // void initState() {
  //   orderBloc = context.read<OrderBloc>();
  //   orderBloc.getAllOrders();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext buildContext) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
        if (state.listingStatus == OrderListStatus.loading) {
          return Container(
            height: MediaQuery.of(context).size.height - 200,
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        }
        if (state.listingStatus == OrderListStatus.error) {
          return Container(
            height: MediaQuery.of(context).size.height - 200,
            alignment: Alignment.center,
            child: fb.TryAgainButton(
              tryAgain: () async {
                await orderBloc.getAllOrders();
              },
            ),
          );
        }

        if (state.orderFilteredList?.isEmpty == true) {
          return EmptyProductView(emptyText: widget.emptyOrderText ?? '-');
        }
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (selectedOrders.length == 1) ...[
                      fb.Button(
                        text: 'Zakaz barada',
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        onPressed: () async {
                          showAppDialog(
                            context,
                            SizedBox(),
                          );
                        },
                      ),
                      SizedBox(
                        width: 14,
                      ),
                    ],
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

  List<DataRow> tableRows(OrderState state) {
    if (state.orders == null) return [];
    var orders = state.orderFilteredList;
    return List.generate(
      orders?.length ?? 0,
      (index) {
        var order = state.orders![index];
        return DataRow(
          selected: selectedOrders.contains(order),
          onSelectChanged: (v) {
            setState(() {
              if (!selectedOrders.contains(order)) {
                selectedOrders.add(order);
              } else {
                selectedOrders.remove(order);
              }
            });
          },
          cells: [
            DataCell(Text("${order.id ?? '-'} ")),
            DataCell(
              fl.DropDownButton(
                leading: fl.Text(order.status ?? '-'),
                items: GadgetStatus.values
                    .map(
                      (e) => fl.MenuFlyoutItem(
                        text: Text(e.name),
                        onPressed: () {
                          
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            DataCell(Text("${order.address?.addressLine1 ?? '-'}")),
            DataCell(Text("${order.note ?? '-'} ")),
            DataCell(
              Wrap(
                spacing: 5,
                children: order.products
                        ?.map(
                          (e) => Text(
                            e.productId.toString(),
                          ),
                        )
                        .toList() ??
                    [],
              ),
            ),
          ],
        );
      },
    );
  }
}
