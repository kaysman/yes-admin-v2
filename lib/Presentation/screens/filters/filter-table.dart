import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:admin_v2/Presentation/screens/filters/filter-create.dart';
import 'package:admin_v2/Presentation/screens/filters/filter-info.dialog.dart';
import 'package:admin_v2/Presentation/screens/filters/filter-update.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/app_colors.dart';

SidebarItem getFiltesSidebarItem() {
  return SidebarItem(
    logo: Icon(
      Icons.filter_alt_outlined,
      size: 40,
      color: kswPrimaryColor,
    ),
    title: "Filterler",
    view: FiltersTable(),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              BlocConsumer<FilterBloc, FilterState>(
                listener: (_, state) {
              
                },
                builder: (context, state) {
                  return SearchFieldInAppBar(
                    hintText: "e.g mb shoes",
                    onEnter: state.listingStatus == FilterListStatus.loading
                        ? null
                        : (value) {
                            print(value);
                            context.read<FilterBloc>().getAllFilters(
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
                  showAppDialog(context, CreateFliterPage());
                },
                child: Text(
                  'Filter döret',
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

class FiltersTable extends StatefulWidget {
  const FiltersTable({Key? key}) : super(key: key);

  @override
  State<FiltersTable> createState() => _FiltersTableState();
}

class _FiltersTableState extends State<FiltersTable> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  List<FilterEntity> selectedFilters = [];
  late FilterBloc filterBloc;
  List<String> columnNames = [
    'ID',
    'Ady tm',
    'Ady ru',
    'Görnüşi',
  ];

  @override
  void initState() {
    filterBloc = context.read<FilterBloc>();
    filterBloc.getAllFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return BlocBuilder<FilterBloc, FilterState>(builder: (_, state) {
        if (state.listingStatus == FilterListStatus.loading) {
          return Container(
            height: MediaQuery.of(context).size.height - 100,
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        }
        if (state.listingStatus == FilterListStatus.error) {
          return Container(
            height: MediaQuery.of(context).size.height - 100,
            alignment: Alignment.center,
            child: TryAgainButton(
              tryAgain: () async {
                await filterBloc.getAllFilters();
              },
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Container(
              //   height: 50,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [],
              //   ),
              // ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (selectedFilters.length == 1) ...[
                      Button(
                        text: 'Filter barada',
                        primary: kswPrimaryColor,
                        textColor: kWhite,
                        onPressed: () {
                          showAppDialog(
                            context,
                            FilterInfo(
                              selectedFilterId: selectedFilters.first.id,
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
                              UpdateFilterPage(filter: selectedFilters.first));
                          setState(
                            () {
                              selectedFilters = [];
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

  List<DataRow> tableRows(FilterState state) {
    if (state.filters == null) return [];
    return List.generate(
      state.filters!.length,
      (index) {
        var filter = state.filters![index];
        return DataRow(
          selected: selectedFilters.contains(filter),
          onSelectChanged: (v) {
            setState(() {
              if (!selectedFilters.contains(filter)) {
                selectedFilters.add(filter);
              } else {
                selectedFilters.remove(filter);
              }
            });
          },
          cells: [
            DataCell(
              Text("${filter.id}"),
            ),
            DataCell(
              Text("${filter.name_tm}"),
            ),
            DataCell(
              Text("${filter.name_ru}"),
            ),
            DataCell(
              Text("${filter.type?.readableText}"),
            ),
          ],
        );
      },
    );
  }
}
