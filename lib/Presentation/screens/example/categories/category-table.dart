import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/sub.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/screens/example/categories/category-tree.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/back-button.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/product-table.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/table-command-bar.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/category-product-search.dart';

class FluentCategoryTable extends StatefulWidget {
  const FluentCategoryTable({Key? key, this.category}) : super(key: key);
  final SubItem? category;

  @override
  State<FluentCategoryTable> createState() => _FluentCategoryTableState();
}

class _FluentCategoryTableState extends State<FluentCategoryTable> {
  ProductEntity? hoveredP;

  final autoSuggestBox = TextEditingController();
  late ProductBloc productBloc;
  CategoryEntity? selectedCategory;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (widget.category != null) {
      productBloc.getAllProducts(
        filter: FilterForProductDTO(category_id: widget.category?.id),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hoveredP != null) {
          setState(() {
            hoveredP = null;
          });
        }
      },
      child: ScaffoldPage(
        header: PageHeader(
          leading: TableBackButton(),
          title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text('Categories')),
          commandBar: TableCommandBar(
            onSearch: () async {
              await showFluentAppDialog(
                context,
                content: CategoryProductSearch(
                  selectedCategory: selectedCategory,
                ),
              );
            },
            onAdd: () async {
              await showFluentAppDialog(
                context,
                content: ProductCreateDialog(),
              );
            },
          ),
        ),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryTreeViewImpl(
              onCategoryChanged: (v) {
                setState(() {
                  selectedCategory = v;
                });
                productBloc.getAllProducts(
                  filter: FilterForProductDTO(category_id: v.id),
                );
              },
            ),
            Expanded(
              child: TableProducts(),
            ),
          ],
        ),
      ),
    );
  }
}
