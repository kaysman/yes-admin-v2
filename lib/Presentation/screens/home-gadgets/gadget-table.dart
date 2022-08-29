import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.state.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/emty-product-view.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/gadget%20-%20create.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/gadget-info.dialog.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/gadget-update.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart';
import 'package:admin_v2/Presentation/shared/components/status-indicator.widget.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/scrollable copy.dart';

SidebarItem getMainPageSidebarItem() {
  return SidebarItem(
    logo: Image.asset(
      'assets/home.png',
      width: 30,
      height: 30,
      color: kswPrimaryColor,
    ),
    title: "Programmanyň Esasy Sahypasy",
    view: GadgetsTable(),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              BlocConsumer<GadgetBloc, GadgetState>(
                listener: (_, state) {
                  if (state.createStatus == BrandCreateStatus.success) {
                    showSnackBar(
                      context,
                      Text(
                        'Created Successully',
                      ),
                      type: SnackbarType.success,
                    );
                  }
                },
                builder: (context, state) {
                  return SearchFieldInAppBar(
                    hintText: "e.g mb shoes",
                    onEnter:
                        // state.listingStatus == BrandListStatus.loading
                        // ? null
                        (value) {
                      // print(value);
                      // context.read<BrandBloc>().getAllBrands(
                      //       filter: PaginationDTO(search: value),
                      //     );
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
                  showAppDialog(context, CreateMainPage());
                },
                child: Text(
                  'Sahypa döret',
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

class GadgetsTable extends StatefulWidget {
  const GadgetsTable({Key? key, this.emptyListText}) : super(key: key);
  final String? emptyListText;

  @override
  State<GadgetsTable> createState() => _GadgetsTableState();
}

class _GadgetsTableState extends State<GadgetsTable> {
  late GadgetBloc gadgetBloc;

  int sortColumnIndex = 0;
  bool sortAscending = true;
  List<GadgetEntity> selectedGadgets = [];

  List<String> columnNames = [
    'ID',
    'Ady',
    'Type',
    'Suratlary',
    'Tertibi',
    'Statusy',
    'Yerlesyan yeri',
    'Linklary',
  ];

  @override
  void initState() {
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return BlocConsumer<GadgetBloc, GadgetState>(
        bloc: gadgetBloc,
        listener: (_, state) {},
        builder: (context, state) {
          if (state.listStatus == GadgetListStatus.loading) {
            return Container(
              height: MediaQuery.of(context).size.height - 200,
              alignment: Alignment.center,
              child: Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              ),
            );
          }
          if (state.listStatus == GadgetListStatus.error) {
            return Container(
              height: MediaQuery.of(context).size.height - 200,
              alignment: Alignment.center,
              child: TryAgainButton(
                tryAgain: () async {
                  await gadgetBloc.getAllGadgets();
                },
              ),
            );
          }

          if (state.filteredGadgets?.isEmpty == true) {
            return EmptyProductView(
              emptyText: widget.emptyListText ?? '-',
              isGadget: true,
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
                      if (selectedGadgets.length == 1) ...[
                        Button(
                          text: 'Gadget barada',
                          primary: kswPrimaryColor,
                          textColor: kWhite,
                          onPressed: () async {
                            showAppDialog(
                              context,
                              GadgetInfo(
                                selectedGadgetId: selectedGadgets.first.id,
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
                                UpdateGadGetPage(
                                  gadget: selectedGadgets.first,
                                ),
                              );
                              setState(() {
                                selectedGadgets = [];
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

  List<DataRow> tableRows(GadgetState state) {
    if (state.gadgets == null) return [];
    return List.generate(
      state.filteredGadgets!.length,
      (index) {
        var gadget = state.filteredGadgets![index];
        return DataRow(
          selected: selectedGadgets.contains(gadget),
          onSelectChanged: (v) {
            setState(() {
              if (!selectedGadgets.contains(gadget)) {
                selectedGadgets.add(gadget);
              } else {
                selectedGadgets.remove(gadget);
              }
            });
          },
          cells: [
            DataCell(
              Text("${gadget.id ?? '-'}"),
            ),
            DataCell(
              Text("${gadget.title ?? '-'}"),
            ),
            DataCell(
              Text("${gadget.type ?? '-'}"),
            ),
            DataCell(Wrap(
              spacing: 5,
              runSpacing: 5,
              children: gadget.items != null
                  ? gadget.items!
                      .map(
                        (e) => e.getFullPathImage == null
                            ? CircleAvatar(
                                radius: 20,
                                backgroundColor: kswPrimaryColor,
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    Image.network(e.getFullPathImage!).image,
                              ),
                      )
                      .toList()
                  : [],
            )),
            DataCell(
              Text("${gadget.queue ?? '-'}"),
            ),
            DataCell(
              StatusIndicator(
                color: gadget.status == "ACTIVE"
                    ? kswPrimaryColor
                    : Colors.redAccent.withOpacity(.8),
                label: "${gadget.status ?? '-'}",
              ),
            ),
            DataCell(
              Text("${gadget.location ?? '-'}"),
            ),
            DataCell(Wrap(
              spacing: 5,
              runSpacing: 5,
              children: gadget.items != null
                  ? gadget.items!
                      .map((e) =>
                          e.link == null ? Text('-') : Text('${e.link ?? '-'}'))
                      .toList()
                  : [],
            )),
          ],
        );
      },
    );
  }
}
