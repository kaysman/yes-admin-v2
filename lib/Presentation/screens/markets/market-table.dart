import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/markets/market-create.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';

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
  int sortColumnIndex = 0;
  bool sortAscending = true;

  List<String> columnNames = [
    'Logo',
    'Ady',
    'Adres',
    'Barada',
    'Telefon',
    'Eyesi',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
                  rows: tableRows,
                ),
              ),
            ),
            Center(
              child: Pagination(
                goPrevious: () {},
                goNext: () {},
                metaData: Meta(
                  totalItems: 50,
                  totalPages: 5,
                  itemCount: 10,
                  currentPage: 1,
                ),
              ),
            ),
          ],
        ),
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

  get tableRows {
    return List.generate(10, (index) {
      return DataRow(
        cells: List.generate(
          columnNames.length,
          (index) => DataCell(
            Text("ABSCDDADJAJSDJ"),
          ),
        ),
      );
    });
  }
}
