import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/services/brand.service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brand.state.dart';

class BrandBloc extends Cubit<BrandState> {
  BrandBloc() : super(BrandState());

  createBrand(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    emit(state.copyWith(createStatus: BrandCreateStatus.loading));
    try {
      var res = await BrandService.createBrand(files, fields);
      List<BrandEntity> l = List<BrandEntity>.from(state.brands ?? []);
      l.add(res!);
      emit(state.copyWith(
        brands: l,
        createStatus: BrandCreateStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(createStatus: BrandCreateStatus.error));
    }
  }

  getBrandById(int id) async {
    emit(state.copyWith(getBrandByIdStatus: GetBrandByIdStatus.loading));
    try {
      var res = await BrandService.getBrandById(id);
      emit(state.copyWith(
        selectedBrand: res,
        getBrandByIdStatus: GetBrandByIdStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(getBrandByIdStatus: GetBrandByIdStatus.error));
    }
  }

  getAllBrands({
    PaginationDTO? filter,
    bool subtle = false,
  }) async {
    emit(state.copyWith(
      listingStatus:
          subtle ? BrandListStatus.silentLoading : BrandListStatus.loading,
    ));
    if (filter == null) {
      filter = PaginationDTO();
    }
    try {
      var res = await BrandService.getBrands(filter.toJson());
      emit(state.copyWith(
        brands: res,
        listingStatus: BrandListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: BrandListStatus.error));
    }
  }

  updateBrand(
    List<FilePickerResult> files,
    Map<String, String> fields,
  ) async {
    try {
      emit(state.copyWith(brandUpdateStatus: BrandUpdateStatus.loading));
      var res = await BrandService.updateBrand(files, fields);

      if (res.success == true) {
        emit(state.copyWith(brandUpdateStatus: BrandUpdateStatus.success));
        getAllBrands();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(brandUpdateStatus: BrandUpdateStatus.error));
    }
  }

  deleteBrand(int id) async {
    try {
      emit(state.copyWith(brandDeleteStatus: BrandDeleteStatus.loading));
      var res = await BrandService.deleteBrand(id);
      if (res.success == true) {
        emit(state.copyWith(brandDeleteStatus: BrandDeleteStatus.success));
        await getAllBrands();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(brandDeleteStatus: BrandDeleteStatus.error));
    }
  }
}
