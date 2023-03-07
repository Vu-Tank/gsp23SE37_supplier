import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item_detail.dart';
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
}
