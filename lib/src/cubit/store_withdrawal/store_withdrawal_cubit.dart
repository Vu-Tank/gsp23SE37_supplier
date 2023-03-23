import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../repositpries/store_repositories.dart';

part 'store_withdrawal_state.dart';

class StoreWithdrawalCubit extends Cubit<StoreWithdrawalState> {
  StoreWithdrawalCubit() : super(StoreWithdrawalInitial());

  storeWithdrawal(
      {required String token,
      required int storeID,
      required double price,
      required String numBankCart,
      required String ownerBankCart,
      required String bankName}) async {
    if (isClosed) return;
    emit(StoreWithdrawalLoading());
    ApiResponse apiResponse = await StoreRepositories.storeWithdrawal(
        storeID: storeID,
        token: token,
        price: price,
        numBankCart: numBankCart,
        ownerBankCart: ownerBankCart.toUpperCase(),
        bankName: bankName);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(StoreWithdrawalSuccess());
    } else {
      if (isClosed) return;
      emit(StoreWithdrawalLoadFailed(apiResponse.msg!));
    }
  }
}
