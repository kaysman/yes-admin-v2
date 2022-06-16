import 'package:admin_v2/Data/models/current-page.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';

enum ProductListStatus { idle, loading, silentLoading, error }

enum ProductCreateStatus { idle, loading, error, success }

enum ProductExcelUploadStatus { idle, loading, error, success }

class ProductState {
  final List<ProductEntity>? products;

  final ProductListStatus? listingStatus;
  final ProductCreateStatus? createStatus;
  final ProductExcelUploadStatus? excelUploadStatus;
  final String? uploadExcelErrorMessage;

  // filter and pagination
  final FilterForProductDTO? lastFilter;
  List<CurrentPage> itemIds;
  CurrentPage? currentPage;

  ProductState({
    this.products,
    this.itemIds = const [],
    this.lastFilter,
    this.currentPage,
    this.excelUploadStatus,
    this.uploadExcelErrorMessage,
    this.listingStatus = ProductListStatus.idle,
    this.createStatus = ProductCreateStatus.idle,
  });

  ProductState copyWith({
    List<ProductEntity>? products,
    ProductListStatus? listingStatus,
    ProductCreateStatus? createStatus,
    FilterForProductDTO? lastFilter,
    ProductExcelUploadStatus? excelStatus,
    String? uploadExcelErrorMessage,
    List<CurrentPage>? itemIds,
    CurrentPage? currentPage,
  }) {
    return ProductState(
      products: products ?? this.products,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
      lastFilter: lastFilter ?? this.lastFilter,
      itemIds: itemIds ?? this.itemIds,
      excelUploadStatus: excelStatus ?? this.excelUploadStatus,
      currentPage: currentPage ?? this.currentPage,
      uploadExcelErrorMessage:
          uploadExcelErrorMessage ?? this.uploadExcelErrorMessage,
    );
  }
}
