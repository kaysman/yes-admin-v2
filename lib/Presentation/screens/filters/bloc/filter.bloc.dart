import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';
import 'package:admin_v2/Data/models/filter/filter.model.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/services/filter_service.dart';
import 'package:admin_v2/Presentation/screens/filters/bloc/filter.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Data/models/filter/filter.enum.dart';

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
        filterTypes: getFilterTypes(l),
        createStatus: FilterCreateStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(createStatus: FilterCreateStatus.error));
    }
  }

  getFilterById(int id) async {
    emit(state.copyWith(getFilterByIdStatus: GetFilterByIdStatus.loading));
    try {
      var res = await FilterService.getFilterById(id);
      emit(state.copyWith(
        selectedFilter: res,
        getFilterByIdStatus: GetFilterByIdStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(getFilterByIdStatus: GetFilterByIdStatus.error));
    }
  }

  getAllFilters({
    PaginationDTO? filter,
    bool subtle = false,
  }) async {
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

      emit(
        state.copyWith(
            filters: res,
            filterTypes: getFilterTypes(res),
            listingStatus: FilterListStatus.idle),
      );
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: FilterListStatus.error));
    }
  }

  updateFilter(FilterEntity data) async {
    emit(state.copyWith(updateStatus: FilterUpdateStatus.loading));
    try {
      var res = await FilterService.updateFilter(data);

      if (res.success == true) {
        emit(state.copyWith(updateStatus: FilterUpdateStatus.success));
        getAllFilters();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(updateStatus: FilterUpdateStatus.error));
    }
  }

  deleteFilter(int id) async {
    emit(state.copyWith(deleteStatus: FilterDeleteStatus.loading));
    try {
      var res = await FilterService.deleteFilter(id);

      if (res.success == true) {
        emit(state.copyWith(deleteStatus: FilterDeleteStatus.success));
        getAllFilters();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(deleteStatus: FilterDeleteStatus.error));
    }
  }
}


///
// * GET FILTER BY TYPE FOR SHOW THEM UNDER TREE
///
getFiltersByType(FilterType type, List<FilterEntity>? filters) {
  return filters?.where((el) => el.type?.name == type.name).toList();
}

getFilterTypes(List<FilterEntity>? filters) {
  List<FilterEntity> sizes = getFiltersByType(FilterType.SIZE, filters);
  List<FilterEntity> genders = getFiltersByType(FilterType.GENDER, filters);
  List<FilterEntity> colors = getFiltersByType(FilterType.COLOR, filters);
  return [
    {
      'Sizes': sizes,
    },
    {
      'Genders': genders,
    },
    {
      'Colors': colors,
    },
  ];
}