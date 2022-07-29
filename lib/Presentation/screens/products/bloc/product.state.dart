import 'package:admin_v2/Data/models/current-page.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';

enum ProductListStatus { idle, loading, silentLoading, error }

enum ProductCreateStatus { idle, loading, error, success }

enum ProductUpdateStatus { idle, loading, error, success }

enum ProductDeleteStatus { idle, loading, error, success }

enum GetProductByIdStatus { idle, loading, error, success }

enum ProductExcelUploadStatus { idle, loading, error, success }

enum ProductImageUploadStatus { idle, loading, error, success }

enum ProductMultiDeleteStatus { idle, loading, error, success }

class ProductState {
  final List<ProductEntity>? products;
  final ProductEntity? selectedProduct;
  final ProductListStatus? listingStatus;
  final ProductCreateStatus? createStatus;
  final ProductUpdateStatus? updateStatus;
  final ProductDeleteStatus? deleteStatus;
  final GetProductByIdStatus? getProductByIdStatus;
  final ProductImageUploadStatus? imageUploadStatus;
  final ProductExcelUploadStatus? excelUploadStatus;
  final ProductMultiDeleteStatus? multiDeleteStatus;
  final String? uploadExcelErrorMessage;
  int? totalProductsCount;
  bool isLastItem;

  // filter and pagination
  final FilterForProductDTO? lastFilter;
  List<CurrentPage> itemIds;
  CurrentPage? currentPage;

  ProductState({
    this.imageUploadStatus = ProductImageUploadStatus.idle,
    this.isLastItem = false,
    this.totalProductsCount,
    this.products,
    this.itemIds = const [],
    this.lastFilter,
    this.currentPage,
    this.excelUploadStatus,
    this.uploadExcelErrorMessage,
    this.listingStatus = ProductListStatus.idle,
    this.createStatus = ProductCreateStatus.idle,
    this.updateStatus = ProductUpdateStatus.idle,
    this.deleteStatus = ProductDeleteStatus.idle,
    this.getProductByIdStatus = GetProductByIdStatus.idle,
    this.multiDeleteStatus = ProductMultiDeleteStatus.idle,
    this.selectedProduct,
  });

  ProductState copyWith({
    bool? isLastItem,
    int? totalProductsCount,
    List<ProductEntity>? products,
    ProductEntity? selectedProduct,
    ProductListStatus? listingStatus,
    ProductCreateStatus? createStatus,
    ProductImageUploadStatus? imageUploadStatus,
    ProductDeleteStatus? deleteStatus,
    ProductUpdateStatus? updateStatus,
    GetProductByIdStatus? getProductByIdStatus,
    ProductMultiDeleteStatus? multiDeleteStatus,
    FilterForProductDTO? lastFilter,
    ProductExcelUploadStatus? excelStatus,
    String? uploadExcelErrorMessage,
    List<CurrentPage>? itemIds,
    CurrentPage? currentPage,
  }) {
    return ProductState(
      isLastItem: isLastItem ?? this.isLastItem,
      totalProductsCount: totalProductsCount ?? this.totalProductsCount,
      products: products ?? this.products,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
      lastFilter: lastFilter ?? this.lastFilter,
      itemIds: itemIds ?? this.itemIds,
      excelUploadStatus: excelStatus ?? this.excelUploadStatus,
      currentPage: currentPage ?? this.currentPage,
      uploadExcelErrorMessage:
          uploadExcelErrorMessage ?? this.uploadExcelErrorMessage,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      getProductByIdStatus: getProductByIdStatus ?? this.getProductByIdStatus,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      multiDeleteStatus: multiDeleteStatus ?? this.multiDeleteStatus,
    );
  }
}
