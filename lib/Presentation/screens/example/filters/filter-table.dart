import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.enum.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Presentation/screens/example/filters/filter-tree.dart';
import 'package:admin_v2/Presentation/screens/example/filters/widgets/filter-product-search.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/back-button.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/table-command-bar.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/screens/products/product-table.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FluentFilterTable extends StatefulWidget {
  const FluentFilterTable({Key? key, this.filter}) : super(key: key);
  final FilterEntity? filter;

  @override
  State<FluentFilterTable> createState() => _FluentFilterTableState();
}

class _FluentFilterTableState extends State<FluentFilterTable> {
  late ProductBloc productBloc;
  FilterEntity? selectedFilter;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (widget.filter != null) {
      selectedFilter = widget.filter;
      getFilteredProducts(productBloc, widget.filter);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        leading: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Text(
            'Filter Table',
            style: FluentTheme.of(context).typography.title,
          ),
        ),
        commandBar: TableCommandBar(onSearch: () async {
          await showFluentAppDialog(
            context,
            title: Text('Search'),
            content: FilterProductSearch(
              selectedFilter: selectedFilter,
            ),
          );
        }, onAdd: () {
          showFluentAppDialog(
            context,
            content: ProductCreateDialog(),
          );
        }),
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: kGrey5Color.withOpacity(.6),
            child: FilterTreeViewImpl(
              onFilterChanged: (v) async {
                setState(() {
                  selectedFilter = v;
                });
                await getFilteredProducts(productBloc, v);
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TableBackButton(),
                    SizedBox(
                      width: 14,
                    ),
                    Text('Products of ${selectedFilter?.name_tm}'),
                  ],
                ),
                ProductsTable(
                  emtyText: 'Filtere degisli haryt, yok!',
                ),
              ],
            ),
            // TableProducts(),
          ),
        ],
      ),
    );
  }
}

///
// * FOR EACH TYPE OF FILTERS
///
getFilteredProducts(ProductBloc productBloc, FilterEntity? filter) {
  log(filter);
  switch (filter?.type) {
    case FilterType.SIZE:
      return productBloc.getAllProducts(
        filter: FilterForProductDTO(size_id: filter?.id),
      );

    case FilterType.GENDER:
      return productBloc.getAllProducts(
        filter: FilterForProductDTO(gender_id: filter?.id),
      );

    case FilterType.COLOR:
      return productBloc.getAllProducts(
        filter: FilterForProductDTO(color_id: filter?.id),
      );

    default:
      return null;
  }
}
