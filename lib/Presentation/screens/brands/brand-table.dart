import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-create.dart';
import 'package:admin_v2/Presentation/screens/brands/brand-info.dialog.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brand-update.dart';

SidebarItem getBrandSidebarItem() {
  return SidebarItem(
      logo: Image.asset(
        'assets/brand_yes.png',
        width: 40,
        height: 40,
        color: kswPrimaryColor,
      ),
      title: "Brendlar",
      view: BrandsTable(),
      getActions: (context) {
        return [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                BlocConsumer<BrandBloc, BrandState>(
                  listener: (_, state) {},
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
    'VIP',
  ];

  @override
  void initState() {
    brandBloc = context.read<BrandBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    brandBloc.getAllBrands();
  }

  @override
  Widget build(BuildContext buildContext) {
    return LayoutBuilder(builder: (_, constraints) {
      return BlocBuilder<BrandBloc, BrandState>(
          bloc: brandBloc,
          builder: (context, state) {
            if (state.listingStatus == BrandListStatus.loading) {
              return Container(
                height: MediaQuery.of(context).size.height - 100,
                alignment: Alignment.center,
                child: Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                ),
              );
            }
            if (state.listingStatus == BrandListStatus.error) {
              return Container(
                height: MediaQuery.of(context).size.height - 100,
                alignment: Alignment.center,
                child: TryAgainButton(
                  tryAgain: () async {
                    await brandBloc.getAllBrands();
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
                        if (selectedBrands.length == 1) ...[
                          Button(
                            text: 'Brand barada',
                            primary: kswPrimaryColor,
                            textColor: kWhite,
                            onPressed: () async {
                              showAppDialog(
                                context,
                                BrandInfo(
                                  selectedBrandId: selectedBrands.first.id,
                                ),
                              );
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
                              await showAppDialog(context,
                                  UpdateBrandPage(brand: selectedBrands.first));
                              setState(
                                () {
                                  selectedBrands = [];
                                },
                              );
                            },
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
              brand.fullPathLogo == null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundColor: kswPrimaryColor,
                    )
                  : CircleAvatar(
                      radius: 20,
                      onBackgroundImageError: (a, b) => CircleAvatar(
                        radius: 20,
                        backgroundColor: kswPrimaryColor,
                      ),
                      backgroundImage: Image.network(brand.fullPathLogo!).image,
                    ),
            ),
            DataCell(
              Text("${brand.name}"),
            ),
            DataCell(
              Text(() {
                return brand.vip == true ? 'Hawa' : 'Yok';
              }()),
            ),
          ],
        );
      },
    );
  }
}
