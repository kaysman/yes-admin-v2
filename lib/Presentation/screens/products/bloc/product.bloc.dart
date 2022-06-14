import 'package:admin_v2/Data/models/product/create-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/services/market.service.dart';
import 'package:admin_v2/Data/services/product_service.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc() : super(ProductState());

  createProduct(CreateProductDTO data) async {
    emit(state.copyWith(createStatus: ProductCreateStatus.loading));
    try {
      var res = await ProductService.createProduct(data);
      List<ProductEntity>? l = List<ProductEntity>.from(state.products ?? []);
      l.add(res!);
      emit(state.copyWith(
        products: l,
        createStatus: ProductCreateStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(createStatus: ProductCreateStatus.error));
    }
  }

  getAllProducts({String? searchQuery}) async {
    emit(state.copyWith(listingStatus: ProductListStatus.loading));
    try {
      var res;
      if (searchQuery != null) {
        print(searchQuery);
      } else {
        res = await ProductService.getProducts();
      }
      emit(state.copyWith(
        products: res,
        listingStatus: ProductListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: ProductListStatus.error));
    }
  }
}
