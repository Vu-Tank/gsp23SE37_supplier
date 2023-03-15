import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/category.dart';
import 'package:gsp23se37_supplier/src/model/item/sub_category.dart';
import 'package:gsp23se37_supplier/src/repositpries/category_repositories.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  bool _isDisposed = false;
  void dispose() {
    _isDisposed = true;
    close();
  }

  loadCategory() async {
    if (_isDisposed) {
      return;
    }
    emit(CategoryLoading());
    ApiResponse apiResponse = await CategoryRepositories.getCategory();
    if (apiResponse.isSuccess!) {
      List<Category> list = apiResponse.data;
      if (isClosed) return;
      emit(CategoryLoaded(list: list, selected: list.first));
    } else {
      if (isClosed) return;
      emit(CategoryLoadFailed(apiResponse.msg!));
    }
  }

  selectedCategory(List<Category> list, Category category) {
    if (_isDisposed) {
      return;
    }
    emit(CategoryLoaded(
        list: list,
        selected: category,
        subCategory:
            (category.listSub.isEmpty) ? null : category.listSub.first));
  }

  selectedSubCategory(
      List<Category> list, Category category, SubCategory subCategory) {
    if (_isDisposed) {
      return;
    }
    emit(CategoryLoaded(
        list: list, selected: category, subCategory: subCategory));
  }
}
