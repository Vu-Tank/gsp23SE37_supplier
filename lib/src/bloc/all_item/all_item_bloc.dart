import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/item.dart';
import 'package:gsp23se37_supplier/src/model/item/item_search.dart';
import 'package:gsp23se37_supplier/src/repositpries/item_repositories.dart';

part 'all_item_event.dart';
part 'all_item_state.dart';

class AllItemBloc extends Bloc<AllItemEvent, AllItemState> {
  AllItemBloc() : super(AllItemInitial()) {
    on<AllItemLoad>((event, emit) async {
      if (isClosed) return;
      emit(AllItemLoading());
      ApiResponse apiResponse = await ItemRepositories.getItems(
          token: event.token, itemSearch: event.itemSearch);
      if (apiResponse.isSuccess!) {
        if (isClosed) return;
        emit(AllItemLoadSuccess(
            list: apiResponse.data,
            currentPage: event.itemSearch.page,
            totalPage: apiResponse.totalPage!));
      } else {
        if (isClosed) return;
        emit(
            AllItemLoadFailed(msg: apiResponse.msg!, search: event.itemSearch));
      }
    });
  }
}
