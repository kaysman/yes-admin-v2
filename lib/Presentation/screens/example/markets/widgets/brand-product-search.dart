import 'package:admin_v2/Data/models/market/market.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/product-search.dialog.dart';
import 'package:admin_v2/Presentation/screens/markets/bloc/market.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketProductSearch extends StatefulWidget {
  const MarketProductSearch({Key? key, required this.selectedMarket})
      : super(key: key);
  final MarketEntity? selectedMarket;

  @override
  State<MarketProductSearch> createState() => _MarketProductSearchState();
}

class _MarketProductSearchState extends State<MarketProductSearch> {
  late ProductBloc productBloc;
  late MarketBloc marketBloc;
  String? searchVal;

  @override
  void initState() {
    marketBloc = BlocProvider.of<MarketBloc>(context);
    if (marketBloc.state.markets == null) {
      marketBloc.getAllMarkets();
    }
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (productBloc.state.products == null) {
      if (widget.selectedMarket != null) {
        productBloc.getAllProducts(
          filter: FilterForProductDTO(
            market_id: widget.selectedMarket?.id,
          ),
        );
      } else {
        var markets = marketBloc.state.markets;
        var market = markets?.isNotEmpty == true ? markets?.first : null;
        productBloc.getAllProducts(
          filter: FilterForProductDTO(market_id: market?.id),
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.listingStatus == ProductListStatus.idle) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var products = state.products;
        return ProductSearch(
          isSearching: state.listingStatus == ProductListStatus.loading,
          products: products,
          onChanged: (v) {
            setState(() {
              searchVal = v;
            });
          },
          onSearch: () async {
            await productBloc.getAllProducts(
              filter: FilterForProductDTO(
                search: searchVal,
              ),
            );
          },
        );
      },
    );
  }
}
