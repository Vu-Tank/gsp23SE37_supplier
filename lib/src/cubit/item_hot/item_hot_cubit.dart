import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/item.dart';
import 'package:gsp23se37_supplier/src/repositpries/item_repositories.dart';

part 'item_hot_state.dart';

class ItemHotCubit extends Cubit<ItemHotState> {
  ItemHotCubit() : super(ItemHotInitial());
  loadHotItem({required String token, required int storeID}) async {
    if (isClosed) return;
    emit(ItemHotLoading());
    ApiResponse apiResponse =
        await ItemRepositories.getItemsHot(token: token, storeID: storeID);
    if (apiResponse.isSuccess!) {
      List<Item> list = apiResponse.data;
      if (list.isNotEmpty && list.length > 5) {
        list.length = list.length - (list.length - 5);
      }
      if (isClosed) return;
      emit(ItemHotLoaded(list));
    } else {
      if (isClosed) return;
      emit(ItemHotFailed(apiResponse.msg!));
    }
  }
}
