import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/cash_flow.dart';
import 'package:gsp23se37_supplier/src/model/cash_flow_search.dart';
import 'package:gsp23se37_supplier/src/repositpries/store_repositories.dart';

part 'cash_flow_state.dart';

class CashFlowCubit extends Cubit<CashFlowState> {
  CashFlowCubit() : super(CashFlowInitial());
  loadCashFlow({required String token, required CashFlowSearch search}) async {
    if (isClosed) return;
    emit(CashFlowLoading());
    ApiResponse apiResponse = await StoreRepositories.storeCashFlow(
        cashFlowSearch: search, token: token);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(CashFlowLoaded(
          list: apiResponse.data,
          curentPage: search.page,
          totalPage: apiResponse.totalPage!));
    } else {
      if (isClosed) return;
      emit(CashFlowLoadFailed(apiResponse.msg!));
    }
  }
}
