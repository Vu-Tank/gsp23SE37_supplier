import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/store_repositories.dart';

import '../../model/reveneu.dart';

part 'store_reveneu_state.dart';

class StoreReveneuCubit extends Cubit<StoreReveneuState> {
  StoreReveneuCubit() : super(StoreReveneuInitial());
  loadReveneu({int? time, required String token, required int storeID}) async {
    if (isClosed) return;
    emit(StoreReveneuLoading());
    ApiResponse apiResponse = await StoreRepositories.storeReveneu(
        orderID: storeID, token: token, time: time);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(StoreReveneuLoaded(list: apiResponse.data, time: time));
    } else {
      emit(StoreReveneuLoadFailed(apiResponse.msg!));
    }
  }
}
