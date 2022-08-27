import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Presentation/screens/example/markets/market-tree.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/back-button.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/table-command-bar.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/product-create.dart';
import 'package:admin_v2/Presentation/screens/products/product-table.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:admin_v2/Presentation/shared/components/button.dart' as f;
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/brand-product-search.dart';

class FluentMarketTable extends StatefulWidget {
  const FluentMarketTable({Key? key, this.market}) : super(key: key);
  final MarketEntity? market;

  @override
  State<FluentMarketTable> createState() => _FluentMarketTableState();
}

class _FluentMarketTableState extends State<FluentMarketTable> {

  final autoSuggestBox = TextEditingController();
  late ProductBloc productBloc;
  MarketEntity? selectedMarket;

  @override
  void initState() {
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (widget.market != null) {
      selectedMarket = widget.market;
      productBloc.getAllProducts(
        filter: FilterForProductDTO(market_id: widget.market?.id),
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
            'Market Table',
            style: FluentTheme.of(context).typography.title,
          ),
        ),
        commandBar: TableCommandBar(onSearch: () async {
          await showFluentAppDialog(
            context,
            title: Text('Search'),
            content: MarketProductSearch(
              selectedMarket: selectedMarket,
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
            child: MarketTreeViewImpl(
              onMarketIdChanged: (v) {
                // log(v);
                setState(() {
                  selectedMarket = v;
                });
                productBloc.getAllProducts(
                  filter: FilterForProductDTO(market_id: v.id),
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
                    Text('Products of ${selectedMarket?.title}'),
                  ],
                ),
                ProductsTable(
                  emtyText: 'Markede degisli haryt, yok!',
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
