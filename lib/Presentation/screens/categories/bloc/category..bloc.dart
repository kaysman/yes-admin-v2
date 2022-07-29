import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Data/models/category/update-category.model.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/services/category.service.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Cubit<CategoryState> {
  CategoryBloc() : super(CategoryState());

  createCategory(CreateCategoryDTO data) async {
    emit(state.copyWith(createStatus: CategoryCreateStatus.loading));
    try {
      var res = await CategoryService.createCategory(data);
      List<CategoryEntity> l =
          List<CategoryEntity>.from(state.categories ?? []);
      l.add(res!);
      emit(state.copyWith(
        categories: l,
        createStatus: CategoryCreateStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(createStatus: CategoryCreateStatus.error));
    }
  }

  getCategoryById(int id) async {
    emit(state.copyWith(getCategoryByIdStatus: GetCategoryByIdStatus.loading));
    try {
      var res = await CategoryService.getCategoryById(id);
      emit(state.copyWith(
        selectedCategory: res,
        getCategoryByIdStatus: GetCategoryByIdStatus.success,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(getCategoryByIdStatus: GetCategoryByIdStatus.error));
    }
  }

  getAllCategories(
      {PaginationDTO? filter,
      bool subtle = false,
      BuildContext? context}) async {
    emit(state.copyWith(
      listingStatus: subtle
          ? CategoryListStatus.silentLoading
          : CategoryListStatus.loading,
    ));

    if (filter == null) {
      filter = PaginationDTO();
    }
    try {
      var res = await CategoryService.getCategories(filter.toJson());
      emit(state.copyWith(
        categories: res,
        listingStatus: CategoryListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: CategoryListStatus.error));
      if (context != null) {
        showSnackBar(context, Text(_.toString()));
      }
    }
  }

  updateCategory(UpdateCategoryDTO data) async {
    emit(state.copyWith(updateStatus: CategoryUpdateStatus.idle));
    try {
      var res = await CategoryService.updateCategory(data);
      if (res.success == true) {
        emit(state.copyWith(
          updateStatus: CategoryUpdateStatus.success,
        ));
        getAllCategories();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(updateStatus: CategoryUpdateStatus.error));
    }
  }

  deleteCategory(int id) async {
    emit(state.copyWith(deleteStatus: CategoryDeleteStatus.idle));
    try {
      var res = await CategoryService.deleteCategory(id);
      if (res.success == true) {
        emit(state.copyWith(
          deleteStatus: CategoryDeleteStatus.success,
        ));
        getAllCategories();
      }
    } catch (_) {
      print(_);
      emit(state.copyWith(deleteStatus: CategoryDeleteStatus.error));
    }
  }
}
