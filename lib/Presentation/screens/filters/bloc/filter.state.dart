import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/filter/filter.entity.model.dart';

enum FilterListStatus { idle, loading, error }

enum FilterCreateStatus { idle, loading, error, success }

class FilterState {
  final List<FilterEntity>? filters;
  final FilterListStatus? listingStatus;
  final FilterCreateStatus? createStatus;

  FilterState({
    this.filters,
    this.listingStatus = FilterListStatus.idle,
    this.createStatus = FilterCreateStatus.idle,
  });

  FilterState copyWith({
    List<FilterEntity>? filters,
    FilterListStatus? listingStatus,
    FilterCreateStatus? createStatus,
  }) {
    return FilterState(
      filters: filters ?? this.filters,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
    );
  }
}
