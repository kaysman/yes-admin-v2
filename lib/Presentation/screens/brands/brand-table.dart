import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-create.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brand-update.dart';

SidebarItem getBrandSidebarItem() {
  return SidebarItem(
    title: "Brendlar",
    view: Container(),
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
              showAppDialog(context, CreateBrandPage());
            },
            child: Text(
              'Brend döret',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ];
    },
  );
}

class BrandsTable extends StatefulWidget {
  const BrandsTable({Key? key}) : super(key: key);

  @override
  State<BrandsTable> createState() => _BrandsTableState();
}

class _BrandsTableState extends State<BrandsTable> {
  late BrandBloc brandBloc;

  int sortColumnIndex = 0;
  bool sortAscending = true;
  List<BrandEntity> selectedBrands = [];

  List<String> columnNames = [
    'Logo',
    'Ady',
    'Suraty',
    'VIP',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<BrandBloc, BrandState>(builder: (context, state) {
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

  List<DataRow> tableRows(BrandState state) {
    if (state.brands == null) return [];
    return List.generate(
      state.brands!.length,
      (index) {
        var brand = state.brands![index];
        return DataRow(
          selected: selectedBrands.contains(brand),
          onSelectChanged: (v) {
            setState(() {
              selectedBrands.add(brand);
            });
          },
          cells: [
            DataCell(
              Text("${brand.logo}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateBrandPage(brand: brand),
                );
              },
            ),
            DataCell(
              Text("${brand.name}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateBrandPage(brand: brand),
                );
              },
            ),
            DataCell(
              Text("${brand.image}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateBrandPage(brand: brand),
                );
              },
            ),
            DataCell(
              Text("${brand.vip}"),
              onTap: () {
                showAppDialog(
                  context,
                  UpdateBrandPage(brand: brand),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
