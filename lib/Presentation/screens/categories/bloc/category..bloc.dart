import 'package:admin_v2/Data/models/category/category.model.dart';
import 'package:admin_v2/Data/models/category/create-category.model.dart';
import 'package:admin_v2/Data/services/category.service.dart';
import 'package:admin_v2/Presentation/screens/categories/bloc/category.state.dart';
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

  getAllCategories() async {
    emit(state.copyWith(listingStatus: CategoryListStatus.loading));
    try {
      var res = await CategoryService.getCategories();
      emit(state.copyWith(
        categories: res,
        listingStatus: CategoryListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: CategoryListStatus.error));
    }
  }
}
