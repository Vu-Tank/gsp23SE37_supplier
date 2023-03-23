import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/data_exchange_repositories.dart';

import '../../model/data_exchange/data_exchange.dart';
import '../../model/data_exchange/data_exchange_search.dart';

part 'data_exchange_state.dart';

class DataExchangeCubit extends Cubit<DataExchangeState> {
  DataExchangeCubit() : super(DataExchangeInitial());
  load({required DataExchangeSearch search, required String token}) async {
    if (isClosed) return;
    emit(DataExchangeLoading());
    ApiResponse apiResponse = await DataExchangeRepositories.getOrders(
        dataSearch: search, token: token);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(DataExchangeSuccess(
          list: apiResponse.data,
          currentPage: search.page,
          totalPage: apiResponse.totalPage!));
    } else {
      emit(DataExchangeFailed(apiResponse.msg!));
    }
  }
}
