import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/item_detail.dart';
import 'package:gsp23se37_supplier/src/model/item/item_status.dart';
import 'package:gsp23se37_supplier/src/repositpries/item_repositories.dart';

part 'item_detail_state.dart';

class ItemDetailCubit extends Cubit<ItemDetailState> {
  ItemDetailCubit() : super(ItemDetailInitial());
  loadItem({required int itemID}) async {
    if (isClosed) return;
    emit(ItemDetailLoading());
    ApiResponse apiResponse =
        await ItemRepositories.getItemDetail(itemID: itemID);
    if (apiResponse.isSuccess!) {
      if (isClosed) {
        return;
      }
      emit(ItemDetailLoaded(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(ItemDetailLoadFailed(apiResponse.msg!));
    }
  }

  hidenItem({required ItemDetail item, required String token}) async {
    if (isClosed) return;
    emit(ItemDetailLoading());
    ApiResponse apiResponse =
        await ItemRepositories.hiddenItem(itemID: item.itemID, token: token);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(ItemDetailLoaded(item.copyWith(
          item_Status: ItemStatus(item_StatusID: 4, statusName: 'Ẩn'))));
    } else {
      emit(ItemDetailLoadFailed(apiResponse.msg!));
    }
  }

  unHidenItem({required ItemDetail item, required String token}) async {
    if (isClosed) return;
    emit(ItemDetailLoading());
    ApiResponse apiResponse =
        await ItemRepositories.unHiddenItem(itemID: item.itemID, token: token);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(ItemDetailLoaded(item.copyWith(
          item_Status: ItemStatus(item_StatusID: 1, statusName: 'Hoạt động'))));
    } else {
      emit(ItemDetailLoadFailed(apiResponse.msg!));
    }
  }
}
