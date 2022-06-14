import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/meta.dart';
import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:admin_v2/Presentation/screens/categories/category-create.dart';
import 'package:admin_v2/Presentation/screens/categories/category-update.dart';
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
          child: OutlinedButton(
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

  List<DataRow> tableRows(CategoryState state) {
    if (state.categories == null) return [];
    return List.generate(
      state.categories!.length,
      (index) {
        var category = state.categories![index];
        return DataRow(
          selected: selectedCategories.contains(category),
          onLongPress: () {
            showAppDialog(
              context,
              UpdateCategoryPage(category: category),
            );
          },
          onSelectChanged: (v) {
            setState(() {
              selectedCategories.add(category);
            });
          },
          cells: [
            DataCell(Text("${category.id}")),
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
