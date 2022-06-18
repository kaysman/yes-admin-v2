import 'package:admin_v2/Data/models/current-page.dart';
import 'package:admin_v2/Data/models/product/create-product.model.dart';
import 'package:admin_v2/Data/models/product/filter-for-product.model.dart';
import 'package:admin_v2/Data/models/product/product.model.dart';
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
      current = CurrentPage(firstId: res.first.id, lastId: res.last.id);
      if (res != null) {
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
}
