import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Presentation/screens/example/filters/filter-table.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/product-search.dialog.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterProductSearch extends StatefulWidget {
  const FilterProductSearch({Key? key, required this.selectedFilter})
      : super(key: key);
  final FilterEntity? selectedFilter;

  @override
  State<FilterProductSearch> createState() => _FilterProductSearchState();
}

class _FilterProductSearchState extends State<FilterProductSearch> {
  late ProductBloc productBloc;
  late FilterBloc filterBloc;
  String? searchVal;

  @override
  void initState() {
    filterBloc = BlocProvider.of<FilterBloc>(context);
    if (filterBloc.state.filters == null) {
      filterBloc.getAllFilters();
    }
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (productBloc.state.products == null) {
      if (widget.selectedFilter != null) {
        getFilteredProducts(productBloc, widget.selectedFilter);
      } else {
        var filters = filterBloc.state.filters;
        var filter = filters?.isNotEmpty == true ? filters?.first : null;
        getFilteredProducts(productBloc, filter);
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
