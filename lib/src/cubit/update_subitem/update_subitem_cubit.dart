import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/item/sub_item.dart';
import 'package:gsp23se37_supplier/src/repositpries/item_repositories.dart';

part 'update_subitem_state.dart';

class UpdateSubitemCubit extends Cubit<UpdateSubitemState> {
  UpdateSubitemCubit() : super(UpdateSubitemInitial());
  updateSubitem({required String token, required SubItem subItem}) async {
    if (isClosed) return;
    emit(UpdateSubItemLoading());
    ApiResponse apiResponse =
        await ItemRepositories.updateSubItem(token: token, subItem: subItem);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateSubitemSuccess());
    } else {
      if (isClosed) return;
      emit(UpdateSubitemFailde(apiResponse.msg!));
    }
  }
}
