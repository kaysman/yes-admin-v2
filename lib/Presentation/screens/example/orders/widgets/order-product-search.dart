import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Presentation/screens/brands/bloc/brand.bloc.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/product-search.dialog.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.bloc.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandProductSearch extends StatefulWidget {
  const BrandProductSearch({Key? key, required this.selectedBrand})
      : super(key: key);
  final BrandEntity? selectedBrand;

  @override
  State<BrandProductSearch> createState() => _BrandProductSearchState();
}

class _BrandProductSearchState extends State<BrandProductSearch> {
  late ProductBloc productBloc;
  late BrandBloc brandBloc;
  String? searchVal;

  @override
  void initState() {
    brandBloc = BlocProvider.of<BrandBloc>(context);
    if (brandBloc.state.brands == null) {
      brandBloc.getAllBrands();
    }
    productBloc = BlocProvider.of<ProductBloc>(context);
    if (productBloc.state.products == null) {
      if (widget.selectedBrand != null) {
        productBloc.getAllProducts(
          filter: FilterForProductDTO(
            brand_id: widget.selectedBrand?.id,
          ),
        );
      } else {
        var brands = brandBloc.state.brands;
        var brand = brands?.isNotEmpty == true ? brands?.first : null;
        productBloc.getAllProducts(
          filter: FilterForProductDTO(brand_id: brand?.id),
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
