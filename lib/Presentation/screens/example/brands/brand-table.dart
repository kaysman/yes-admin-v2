import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Presentation/screens/example/brands/brands-tree.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/back-button.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/table-command-bar.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/screens/products/product-table.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/brand-product-search.dart';

class FluentBrandTable extends StatefulWidget {
  const FluentBrandTable({Key? key, this.brand}) : super(key: key);
  final BrandEntity? brand;

  @override
  State<FluentBrandTable> createState() => _FluentBrandTableState();
}

class _FluentBrandTableState extends State<FluentBrandTable> {
  final autoSuggestBox = TextEditingController();
  late ProductBloc productBloc;
  BrandEntity? selectedBrand;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (widget.brand != null) {
      selectedBrand = widget.brand;
      productBloc.getAllProducts(
        filter: FilterForProductDTO(brand_id: widget.brand?.id),
      );
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
            'Brand Table',
            style: FluentTheme.of(context).typography.title,
          ),
        ),
        commandBar: TableCommandBar(onSearch: () async {
          await showFluentAppDialog(
            context,
            content: BrandProductSearch(
              selectedBrand: selectedBrand,
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
            child: BrandTreeViewImpl(
              onBrandIdChanged: (v) {
                // log(v);
                setState(() {
                  selectedBrand = v;
                });
                productBloc.getAllProducts(
                  filter: FilterForProductDTO(brand_id: v.id),
                );
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
                    Text('Products of ${selectedBrand?.name}'),
                  ],
                ),
                ProductsTable(
                  emtyText: 'Brenda degisli haryt, yok!',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
