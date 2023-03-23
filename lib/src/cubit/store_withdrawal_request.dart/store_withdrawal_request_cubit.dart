import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal_search.dart';
import 'package:gsp23se37_supplier/src/repositpries/service_repositories.dart';

part 'store_withdrawal_request_state.dart';

class StoreWithdrawalRequestCubit extends Cubit<StoreWithdrawalRequestState> {
  StoreWithdrawalRequestCubit() : super(StoreWithdrawalRequestInitial());

  load({required WithdrawalSearch search, required String token}) async {
    if (isClosed) return;
    emit(StoreWithdrawalRequestLoading());
    ApiResponse apiResponse = await ServiceRepositorie.getWithdrawals(
        token: token, withdrawalSearch: search);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(StoreWithdrawalRequestSuccess(
          list: apiResponse.data,
          currentPage: search.page,
          totalPage: apiResponse.totalPage!));
    } else {
      emit(StoreWithdrawalRequestFailed(apiResponse.msg!));
    }
  }
}
