import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/item/item.dart';
import '../../repositpries/item_repositories.dart';

part 'items_block_event.dart';
part 'items_block_state.dart';

class ItemsBlockBloc extends Bloc<ItemsBlockEvent, ItemsBlockState> {
  ItemsBlockBloc() : super(ItemsBlockInitial()) {
    on<ItemsBlockLoad>((event, emit) async {
      if (isClosed) return;
      emit(ItemsBlockLoading());
      ApiResponse apiResponse = await ItemRepositories.getItem(
          storeId: event.storeId,
          token: event.token,
          page: event.page,
          statusID: '2');
      if (apiResponse.isSuccess!) {
        if (isClosed) return;
        emit(ItemsBlockLoadSuccess(
            list: apiResponse.data,
            currentPage: event.page,
            totalPage: apiResponse.totalPage!));
      } else {
        if (isClosed) return;
        emit(ItemsBlockLoadFailed(apiResponse.msg!));
      }
    });
  }
}
