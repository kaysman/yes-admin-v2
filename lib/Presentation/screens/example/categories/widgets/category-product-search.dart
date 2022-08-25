import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category..bloc.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/product-search.dialog.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:admin_v2/Presentation/screens/products/dialogs/product-create-info.dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/bloc/product.bloc.dart';

class CategoryProductSearch extends StatefulWidget {
  const CategoryProductSearch({Key? key, required this.selectedCategory})
      : super(key: key);
  final CategoryEntity? selectedCategory;

  @override
  State<CategoryProductSearch> createState() => _CategoryProductSearchState();
}

class _CategoryProductSearchState extends State<CategoryProductSearch> {
  late ProductBloc productBloc;
  late CategoryBloc categoryBloc;
  String? searchVal;

  @override
  void initState() {
    categoryBloc = BlocProvider.of<CategoryBloc>(context);
    if (categoryBloc.state.categories == null) {
      categoryBloc.getAllCategories();
    }
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (productBloc.state.products == null) {
      if (widget.selectedCategory != null) {
        productBloc.getAllProducts(
          filter: FilterForProductDTO(
            category_id: widget.selectedCategory?.id,
          ),
        );
      } else {
        var subs = getSubs(categoryBloc.state.categories);
        var sub = subs.isNotEmpty == true ? subs.first : null;
        productBloc.getAllProducts(
          filter: FilterForProductDTO(category_id: sub?.id),
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