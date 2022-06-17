import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/categories/category-create.dart';
import 'package:admin_v2/Presentation/screens/categories/category-update.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/appbar.components.dart';
import 'package:admin_v2/Presentation/shared/components/pagination.dart';
import 'package:admin_v2/Presentation/shared/components/scrollable.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/category..bloc.dart';
import 'bloc/category.state.dart';

SidebarItem getCategoriesdebarItem() {
  return SidebarItem(
    title: "Kategoriyalar",
    view: CategoriesTable(),
    getActions: (context) {
      return [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              BlocConsumer<CategoryBloc, CategoryState>(
                listener: (_, state) {
                  if (state.createStatus == CategoryCreateStatus.success) {
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
                    onEnter: state.listingStatus == CategoryListStatus.loading
                        ? null
                        : (value) {
                            print(value);
                            context.read<CategoryBloc>().getAllCategories(
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
                  showAppDialog(context, CreateCategoryPage());
                },
                child: Text(
                  'Kategoriya döret',
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

class CategoriesTable extends StatefulWidget {
  const CategoriesTable({Key? key}) : super(key: key);

  @override
  State<CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<CategoriesTable> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  List<CategoryEntity> selectedCategories = [];
  late CategoryBloc categoryBloc;
  List<String> columnNames = [
    'ID',
    'Ady tm',
    'Ady ru',
    'Barada tm',
    'Barada ru',
  ];

  @override
  void initState() {
    categoryBloc = context.read<CategoryBloc>();
    categoryBloc.getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
        return state.listingStatus == CategoryListStatus.loading
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
                          if (selectedCategories.length == 1)
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                              onPressed: () {
                                showAppDialog(
                                  context,
                                  UpdateCategoryPage(
                                    category: selectedCategories.first,
                                  ),
                                );
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

  List<DataRow> tableRows(CategoryState state) {
    if (state.categories == null) return [];
    return List.generate(
      state.categories!.length,
      (index) {
        var category = state.categories![index];
        return DataRow(
          selected: selectedCategories.contains(category),
          onSelectChanged: (v) {
            setState(() {
              if (!selectedCategories.contains(category)) {
                selectedCategories.add(category);
              } else {
                selectedCategories.remove(category);
              }
            });
          },
          cells: [
            DataCell(
                onTap: () => showAppDialog(
                      context,
                      SubCategoriesPage(subCategories: category.subcategories),
                    ),
                Text("${category.id}")),
            DataCell(Text("${category.title_tm}")),
            DataCell(Text("${category.title_ru}")),
            DataCell(Text("${category.description_tm}")),
            DataCell(Text("${category.description_ru}")),
          ],
        );
      },
    );
  }
}

class SubCategoriesPage extends StatelessWidget {
  final List<CategoryEntity>? subCategories;
  const SubCategoriesPage({Key? key, required this.subCategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: subCategories?.map((e) {
              return ListTile(
                title: Text('${e.title_tm}'),
              );
            }).toList() ??
            [],
      ),
    );
  }
}
