import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/item/item.dart';
import '../../repositpries/item_repositories.dart';

part 'item_pending_event.dart';
part 'item_pending_state.dart';

class ItemPendingBloc extends Bloc<ItemPendingEvent, ItemPendingState> {
  ItemPendingBloc() : super(ItemPendingInitial()) {
    on<ItemPendingLoad>((event, emit) async {
      if (isClosed) return;
      emit(ItemPendingLoading());
      ApiResponse apiResponse = await ItemRepositories.getItem(
          storeId: event.storeId,
          token: event.token,
          page: event.page,
          statusID: '3');
      if (apiResponse.isSuccess!) {
        if (isClosed) return;
        emit(ItemPendingLoadSuccess(
            list: apiResponse.data,
            currentPage: event.page,
            totalPage: apiResponse.totalPage!));
      } else {
        if (isClosed) return;
        emit(ItemPendingLoadFailed(apiResponse.msg!));
      }
    });
  }
}
