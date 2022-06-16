import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/services/filter_service.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Cubit<FilterState> {
  FilterBloc() : super(FilterState());

  createFilter(FilterDTO data) async {
    emit(state.copyWith(createStatus: FilterCreateStatus.loading));
    try {
      var res = await FilterService.createFilter(data);
      List<FilterEntity> l = List<FilterEntity>.from(state.filters ?? []);
      l.add(res!);
      emit(state.copyWith(
        filters: l,
        createStatus: FilterCreateStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(createStatus: FilterCreateStatus.error));
    }
  }

  getAllFilters({PaginationDTO? filter, bool subtle = false}) async {
    emit(
      state.copyWith(
        listingStatus:
            subtle ? FilterListStatus.silentLoading : FilterListStatus.loading,
      ),
    );

    if (filter == null) {
      filter = PaginationDTO();
    }
    try {
      var res = await FilterService.getFilters(filter.toJson());
      emit(state.copyWith(filters: res, listingStatus: FilterListStatus.idle));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: FilterListStatus.error));
    }
  }
}
