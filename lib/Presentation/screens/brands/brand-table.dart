import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-create.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brand-update.dart';

SidebarItem getBrandSidebarItem() {
  return SidebarItem(
      title: "Brendlar",
      view: BrandsTable(),
      getActions: (context) {
        return [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                BlocConsumer<BrandBloc, BrandState>(
                  listener: (_, state) {
                    if (state.createStatus == BrandCreateStatus.success) {
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
                      onEnter: state.listingStatus == BrandListStatus.loading
                          ? null
                          : (value) {
                              print(value);
                              context.read<BrandBloc>().getAllBrands(
                                    filter: PaginationDTO(search: value),
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
                    showAppDialog(context, CreateBrandPage());
                  },
                  child: Text(
                    'Brend döret',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ];
      });
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
    'ID',
    'Logo',
    'Ady',
    'Suraty',
    'VIP',
  ];

  @override
  void initState() {
    brandBloc = context.read<BrandBloc>();
    brandBloc.getAllBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<BrandBloc, BrandState>(
          bloc: brandBloc,
          builder: (context, state) {
            return state.listingStatus == BrandListStatus.loading
                ? Center(
                    child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ))
                : Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (selectedBrands.length == 1)
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                  onPressed: () {
                                    var _market = selectedBrands.firstWhere(
                                      (e) => e.isSelected == false,
                                    );
                                    showAppDialog(context,
                                        UpdateBrandPage(brand: _market));
                                  },
                                  child: Text(
                                    'Uytget',
                                    style: TextStyle(color: Colors.white),
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
              if (!selectedBrands.contains(brand)) {
                selectedBrands.add(brand);
              } else {
                selectedBrands.remove(brand);
              }
            });
          },
          cells: [
            DataCell(
              Text("${brand.id}"),
            ),
            DataCell(
              Text("${brand.logo}"),
            ),
            DataCell(
              Text("${brand.name}"),
            ),
            DataCell(
              Text("${brand.image}"),
            ),
            DataCell(
              Text(() {
                return brand.vip ? 'Hawa' : 'Yok';
              }()),
            ),
          ],
        );
      },
    );
  }
}
