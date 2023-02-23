import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/category.dart';
import 'package:gsp23se37_supplier/src/model/sub_category.dart';
import 'package:gsp23se37_supplier/src/repositpries/category_repositories.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  loadCategory() async {
    emit(CategoryLoading());
    ApiResponse apiResponse = await CategoryRepositories.getCategory();
    if (apiResponse.isSuccess!) {
      List<Category> list = apiResponse.data;
      emit(CategoryLoaded(list: list, selected: list.first));
    } else {
      emit(CategoryLoadFailed(apiResponse.msg!));
    }
  }

  selectedCategory(List<Category> list, Category category) {
    emit(CategoryLoaded(
        list: list,
        selected: category,
        subCategory:
            (category.listSub.isEmpty) ? null : category.listSub.first));
  }

  selectedSubCategory(
      List<Category> list, Category category, SubCategory subCategory) {
    emit(CategoryLoaded(
        list: list, selected: category, subCategory: subCategory));
  }
}
