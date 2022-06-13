import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/brand/create-brand.model.dart';
import 'package:admin_v2/Data/services/brand.service.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FilterBloc extends Cubit<FilterState> {
  FilterBloc() : super(FilterState());

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

  getAllBrands() async {
    emit(state.copyWith(listingStatus: BrandListStatus.loading));
    try {
      var res = await BrandService.getBrands();
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
