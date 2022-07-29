import 'package:admin_v2/Data/models/current-page.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
import 'package:admin_v2/Data/models/product/update-product.model.dart';
import 'package:admin_v2/Data/services/product_service.dart';
import 'package:admin_v2/Presentation/screens/products/bloc/product.state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/models/product/delete-many-products.model.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc() : super(ProductState());

  createProduct(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    emit(state.copyWith(createStatus: ProductCreateStatus.loading));
    try {
      var res = await ProductService.createProduct(files, fields);
      List<ProductEntity>? l = List<ProductEntity>.from(state.products ?? []);
      l.add(res);
      emit(state.copyWith(
        products: l,
        createStatus: ProductCreateStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(createStatus: ProductCreateStatus.error));
    }
  }

  updateProduct(UpdateProductDTO data) async {
    emit(state.copyWith(updateStatus: ProductUpdateStatus.loading));
    try {
      var res = await ProductService.updateProduct(data);
      if (res.success == true) {
        emit(
          state.copyWith(
            updateStatus: ProductUpdateStatus.success,
          ),
        );
        getAllProducts();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(updateStatus: ProductUpdateStatus.error));
    }
  }

  deleteProduct(int id) async {
    emit(state.copyWith(deleteStatus: ProductDeleteStatus.loading));
    try {
      var res = await ProductService.deleteProduct(id);
      if (res.success == true) {
        emit(
          state.copyWith(
            deleteStatus: ProductDeleteStatus.success,
          ),
        );
        getAllProducts();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(deleteStatus: ProductDeleteStatus.error));
    }
  }
  multiDeleteProduct(DeleteMultiProductModel data) async {
    emit(state.copyWith(multiDeleteStatus: ProductMultiDeleteStatus.loading));
    try {
      var res = await ProductService.multiDeleteProduct(data);
      if (res.success == true) {
        emit(
          state.copyWith(
            multiDeleteStatus: ProductMultiDeleteStatus.success,
          ),
        );
        getAllProducts();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(multiDeleteStatus: ProductMultiDeleteStatus.error));
    }
  }

  getProductById(int id) async {
    emit(state.copyWith(getProductByIdStatus: GetProductByIdStatus.loading));
    try {
      var res = await ProductService.getProductById(id);
      emit(
        state.copyWith(
          selectedProduct: res,
          getProductByIdStatus: GetProductByIdStatus.success,
        ),
      );
    } catch (_) {
      print(_);
      emit(state.copyWith(getProductByIdStatus: GetProductByIdStatus.error));
    }
  }

  getAllProducts({FilterForProductDTO? filter, bool subtle = false}) async {
    if (filter == null) {
      filter = FilterForProductDTO();
    }

    emit(
      state.copyWith(
          listingStatus: subtle
              ? ProductListStatus.silentLoading
              : ProductListStatus.loading),
    );

    try {
      if (filter.next == true) {
        filter.lastId = state.currentPage!.lastId;
      } else if (filter.next == false) {
        var index = state.itemIds.indexOf(state.currentPage!);
        filter.lastId = state.itemIds[index - 1].firstId;
      }

      var res = await ProductService.getProducts(filter.toJson());

      List<CurrentPage> ids = [];
      CurrentPage? current;
      ids.addAll(state.itemIds);
      current = res.length > 0
          ? CurrentPage(firstId: res.first.id, lastId: res.last.id)
          : CurrentPage(
              firstId: null,
              lastId: null,
            );
      if (res.isNotEmpty) {
        if (res.first.id != res.last.id && !state.itemIds.contains(current)) {
          state.totalProductsCount =
              (state.totalProductsCount ?? 0) + (res.length);
        } else if (!state.itemIds.contains(current)) {
          state.totalProductsCount = (state.totalProductsCount ?? 0) + 1;
        }

        if (!ids.contains(current)) {
          ids.add(current);
        }
      }
      emit(state.copyWith(
        totalProductsCount: state.totalProductsCount,
        products: res,
        lastFilter: filter,
        itemIds: ids,
        currentPage: current,
        listingStatus: ProductListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: ProductListStatus.error));
    }
  }

  uploadExcel(String filename, List<int> bytes) async {
    emit(state.copyWith(excelStatus: ProductExcelUploadStatus.loading));
    try {
      var res = await ProductService.uploadExcel(filename, bytes);
      if (res.success == true) {
        emit(state.copyWith(excelStatus: ProductExcelUploadStatus.success));
        getAllProducts();
      } else if (res.success == false) {
        emit(state.copyWith(
          excelStatus: ProductExcelUploadStatus.error,
          uploadExcelErrorMessage: res.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        excelStatus: ProductExcelUploadStatus.error,
        uploadExcelErrorMessage: e.toString(),
      ));
    }
  }

  uploadImage(String filename, List<int> bytes) async {
    emit(state.copyWith(imageUploadStatus: ProductImageUploadStatus.loading));
    try {
      var res = await ProductService.uploadImage(filename, bytes);
      if (res.success == true) {
        emit(state.copyWith(
            imageUploadStatus: ProductImageUploadStatus.success));
        getAllProducts();
      } else if (res.success == false) {
        emit(state.copyWith(
          imageUploadStatus: ProductImageUploadStatus.error,
          uploadExcelErrorMessage: res.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        imageUploadStatus: ProductImageUploadStatus.error,
        uploadExcelErrorMessage: e.toString(),
      ));
    }
  }
}
