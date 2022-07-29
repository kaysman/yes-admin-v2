import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.state.dart';
import 'package:admin_v2/Presentation/screens/markets/market-create.dart';
import 'package:admin_v2/Presentation/screens/markets/market-info.dart';
import 'package:admin_v2/Presentation/screens/markets/market-update.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

SidebarItem getMarketSidebarItem() {
  return SidebarItem(
    logo: SvgPicture.asset(
      'assets/pick-up.svg',
      color: kswPrimaryColor,
      width: 30,
      height: 30,
      fit: BoxFit.contain,
    ),
    title: "Marketlar",
    view: SingleChildScrollView(child: MarketsTable()),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              BlocConsumer<MarketBloc, MarketState>(
                listener: (_, state) {},
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
    return LayoutBuilder(builder: (_, constraints) {
      return BlocConsumer<MarketBloc, MarketState>(
        bloc: marketBloc,
        listener: (_, state) {},
        builder: (context, state) {
          if (state.listingStatus == MarketListStatus.loading) {
            return Container(
              height: MediaQuery.of(context).size.height - 100,
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            );
          }
          if (state.listingStatus == MarketListStatus.error) {
            return Container(
              height: MediaQuery.of(context).size.height - 100,
              alignment: Alignment.center,
              child: TryAgainButton(
                tryAgain: () async {
                  await marketBloc.getAllMarkets();
                },
              ),
            );
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
                      if (selectedMarkets.length == 1) ...[
                        Button(
                          text: 'Market barada',
                          primary: kswPrimaryColor,
                          textColor: kWhite,
                          onPressed: () async {
                            showAppDialog(
                              context,
                              MarketInfo(
                                selectedMarketId: selectedMarkets.first.id,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Button(
                            text: 'Uytget',
                            primary: kswPrimaryColor,
                            textColor: kWhite,
                            onPressed: () async {
                              await showAppDialog(
                                context,
                                UpdateMarketPage(
                                  market: selectedMarkets.first,
                                ),
                              );
                              setState(() {
                                selectedMarkets = [];
                              });
                            },
                          ),
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
