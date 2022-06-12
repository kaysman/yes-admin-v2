import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
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
    view: MarketsTable(),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SearchFieldInAppBar(hintText: "e.g mb shoes"),
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
      return BlocBuilder<MarketBloc, MarketState>(
        bloc: marketBloc,
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
                Pagination(
                  goPrevious: () {},
                  goNext: () {},
                  metaData: Meta(
                    totalItems: 50,
                    totalPages: 5,
                    itemCount: 10,
                    currentPage: 1,
                  ),
                ),
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
              selectedMarkets.add(market);
            });
          },
          cells: [
            DataCell(
              Text("${market.logo}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateMarketPage(market: market),
                );
              },
            ),
            DataCell(
              Text("${market.title}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateMarketPage(market: market),
                );
              },
            ),
            DataCell(
              Text("${market.address}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateMarketPage(market: market),
                );
              },
            ),
            DataCell(
              Text("${market.description}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateMarketPage(market: market),
                );
              },
            ),
            DataCell(
              Text("${market.phoneNumber}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateMarketPage(market: market),
                );
              },
            ),
            DataCell(
              Text("${market.ownerName}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateMarketPage(market: market),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
