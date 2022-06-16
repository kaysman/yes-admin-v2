import 'package:admin_v2/Data/models/category/category.model.dart';

enum CategoryListStatus { idle, loading, error , silentLoading}

enum CategoryCreateStatus { idle, loading, error, success }

class CategoryState {
  final List<CategoryEntity>? categories;
  final CategoryListStatus? listingStatus;
  final CategoryCreateStatus? createStatus;

  CategoryState({
    this.categories,
    this.listingStatus = CategoryListStatus.idle,
    this.createStatus = CategoryCreateStatus.idle,
  });

  CategoryState copyWith({
    List<CategoryEntity>? categories,
    CategoryListStatus? listingStatus,
    CategoryCreateStatus? createStatus,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
    );
  }
}
