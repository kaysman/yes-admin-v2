import 'package:admin_v2/Data/models/category/category.model.dart';

enum FilterListStatus { idle, loading, error }

enum FilterCreateStatus { idle, loading, error, success }

class FilterState {
  final List<CategoryEntity>? categories;
  final FilterListStatus? listingStatus;
  final FilterCreateStatus? createStatus;

  FilterState({
    this.categories,
    this.listingStatus = FilterListStatus.idle,
    this.createStatus = FilterCreateStatus.idle,
  });

  FilterState copyWith({
    List<CategoryEntity>? categories,
    FilterListStatus? listingStatus,
    FilterCreateStatus? createStatus,
  }) {
    return FilterState(
      categories: categories ?? this.categories,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
    );
  }
}
