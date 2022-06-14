import 'package:admin_v2/Data/models/product/product.model.dart';

enum ProductListStatus { idle, loading, error }

enum ProductCreateStatus { idle, loading, error, success }

class ProductState {
  final List<ProductEntity>? products;
  final ProductListStatus? listingStatus;
  final ProductCreateStatus? createStatus;

  ProductState({
    this.products,
    this.listingStatus = ProductListStatus.idle,
    this.createStatus = ProductCreateStatus.idle,
  });

  ProductState copyWith({
    List<ProductEntity>? products,
    ProductListStatus? listingStatus,
    ProductCreateStatus? createStatus,
  }) {
    return ProductState(
      products: products ?? this.products,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
    );
  }
}
