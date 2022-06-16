import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/screens/markets/market-create.dart';
import 'package:admin_v2/Presentation/screens/markets/market-update.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

SidebarItem getMarketSidebarItem() {
  return SidebarItem(
    title: "Marketlar",
    view: SingleChildScrollView(child: MarketsTable()),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              BlocConsumer<MarketBloc, MarketState>(
                listener: (_, state) {
                  if (state.createStatus == MarketCreateStatus.success) {
                    Scaffold.of(context)
                        // ignore: deprecated_member_use
                        .showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.lightBlue,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(milliseconds: 1000),
                        content: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30,
                          ),
                          child: new Text(
                            'Created Successully',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(
                                    color: Colors.white, letterSpacing: 1),
                          ),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SearchFieldInAppBar(
                    hintText: "e.g mb shoes",
                    onEnter: state.listingStatus == MarketListStatus.loading
                        ? null
                        : (value) {
                            print(value);
                            context.read<MarketBloc>().getAllMarkets(
                                filter: PaginationDTO(search: value));
                          },
                  );
                },
              ),
              SizedBox(width: 14),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  onSurface: Colors.white,
                  primary: Colors.transparent,
                ),
                onPressed: () {
                  showAppDialog(context, CreateMarketPage());
                },
                child: Text(
                  'Market döret',
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

class MarketsTable extends StatefulWidget {
  const MarketsTable({Key? key}) : super(key: key);

  @override
  State<MarketsTable> createState() => _MarketsTableState();
}

class _MarketsTableState extends State<MarketsTable> {
  late MarketBloc marketBloc;

  int sortColumnIndex = 0;
  bool sortAscending = true;
  List<MarketEntity> selectedMarkets = [];

  List<String> columnNames = [
    'ID',
    'Logo',
    'Ady',
    'Adres',
    'Barada',
    'Telefon',
    'Eyesi',
  ];

  @override
  void initState() {
    marketBloc = BlocProvider.of<MarketBloc>(context);
    marketBloc.getAllMarkets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocConsumer<MarketBloc, MarketState>(
        bloc: marketBloc,
        listener: (contex, state) {},
        builder: (context, state) {
          return state.listingStatus == MarketListStatus.loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (selectedMarkets.length == 1)
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                  onPressed: () {
                                    showAppDialog(
                                        context,
                                        UpdateMarketPage(
                                            market: selectedMarkets.first));
                                  },
                                  child: Text(
                                    'Uytget',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
        },
      );
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

  List<DataRow> tableRows(MarketState state) {
    if (state.markets == null) return [];
    return List.generate(
      state.markets!.length,
      (index) {
        var market = state.markets![index];
        return DataRow(
          selected: selectedMarkets.contains(market),
          onSelectChanged: (v) {
            setState(() {
              if (!selectedMarkets.contains(market)) {
                selectedMarkets.add(market);
              } else {
                selectedMarkets.remove(market);
              }
            });
          },
          cells: [
            DataCell(
              Text("${market.id}"),
            ),
            DataCell(
              Text("${market.logo}"),
            ),
            DataCell(
              Text("${market.title}"),
            ),
            DataCell(
              Text("${market.address}"),
            ),
            DataCell(
              Text("${market.description}"),
            ),
            DataCell(
              Text("${market.phoneNumber}"),
            ),
            DataCell(
              Text("${market.ownerName}"),
            ),
          ],
        );
      },
    );
  }
}
