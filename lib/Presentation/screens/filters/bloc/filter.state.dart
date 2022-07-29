import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';

enum FilterListStatus { idle, loading, error, silentLoading }

enum FilterCreateStatus { idle, loading, error, success }

enum FilterUpdateStatus { idle, loading, error, success }

enum FilterDeleteStatus { idle, loading, error, success }

enum GetFilterByIdStatus { idle, loading, error, success }

class FilterState {
  final List<FilterEntity>? filters;
  final FilterListStatus? listingStatus;
  final FilterCreateStatus? createStatus;
  final FilterUpdateStatus? updateStatus;
  final FilterDeleteStatus? deleteStatus;
  final GetFilterByIdStatus? getFilterByIdStatus;
  final FilterEntity? selectedFilter;

  FilterState({
    this.filters,
    this.listingStatus = FilterListStatus.idle,
    this.createStatus = FilterCreateStatus.idle,
    this.updateStatus = FilterUpdateStatus.idle,
    this.deleteStatus = FilterDeleteStatus.idle,
    this.getFilterByIdStatus = GetFilterByIdStatus.idle,
    this.selectedFilter,
  });

  FilterState copyWith(
      {List<FilterEntity>? filters,
      FilterListStatus? listingStatus,
      FilterCreateStatus? createStatus,
      FilterUpdateStatus? updateStatus,
      FilterDeleteStatus? deleteStatus,
      GetFilterByIdStatus? getFilterByIdStatus,
      FilterEntity? selectedFilter}) {
    return FilterState(
      filters: filters ?? this.filters,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      getFilterByIdStatus: getFilterByIdStatus ?? this.getFilterByIdStatus,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}
