import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/services/brand.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'brand.state.dart';

class BrandBloc extends Cubit<BrandState> {
  BrandBloc() : super(BrandState());

  createBrand(CreateBrandDTO data) async {
    emit(state.copyWith(createStatus: BrandCreateStatus.loading));
    try {
      var res = await BrandService.createBrand(data);
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

  getAllBrands({PaginationDTO? filter, bool subtle = false}) async {
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

}
