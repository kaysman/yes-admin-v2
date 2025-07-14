import 'package:admin_v2/Data/models/category/category.model.dart';

enum CategoryListStatus { idle, loading, error, silentLoading }

enum CategoryCreateStatus { idle, loading, error, success }

enum CategoryUpdateStatus { idle, loading, error, success }

enum CategoryDeleteStatus { idle, loading, error, success }

enum GetCategoryByIdStatus { idle, loading, error, success }

class CategoryState {
  final List<CategoryEntity>? categories;
  final CategoryListStatus? listingStatus;
  final CategoryCreateStatus? createStatus;
  final CategoryUpdateStatus? updateStatus;
  final CategoryDeleteStatus? deleteStatus;
  final GetCategoryByIdStatus? getCategoryByIdStatus;
  final CategoryEntity? selectedCategory;

  CategoryState({
    this.categories,
    this.listingStatus = CategoryListStatus.idle,
    this.createStatus = CategoryCreateStatus.idle,
    this.updateStatus = CategoryUpdateStatus.idle,
    this.deleteStatus = CategoryDeleteStatus.idle,
    this.getCategoryByIdStatus = GetCategoryByIdStatus.idle,
    this.selectedCategory,
  });

  CategoryState copyWith({
    List<CategoryEntity>? categories,
    CategoryListStatus? listingStatus,
    CategoryCreateStatus? createStatus,
    CategoryUpdateStatus? updateStatus,
    CategoryDeleteStatus? deleteStatus,
    GetCategoryByIdStatus? getCategoryByIdStatus,
    CategoryEntity? selectedCategory,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      listingStatus: listingStatus ?? this.listingStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      getCategoryByIdStatus:
          getCategoryByIdStatus ?? this.getCategoryByIdStatus,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
