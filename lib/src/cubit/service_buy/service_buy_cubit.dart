import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/service/service.dart';
import 'package:gsp23se37_supplier/src/model/service/service_search.dart';
import 'package:gsp23se37_supplier/src/repositpries/service_repositories.dart';

part 'service_buy_state.dart';

class ServiceBuyCubit extends Cubit<ServiceBuyState> {
  ServiceBuyCubit() : super(ServiceBuyInitial());

  loadService({required String token, required ServiceSearch search}) async {
    if (isClosed) return;
    emit(ServiceBuyLoading());
    ApiResponse apiResponse = await ServiceRepositorie.getServiceBuy(
        token: token, searchService: search);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(ServiceBuyLoadSuccess(
          list: apiResponse.data,
          totalPage: apiResponse.totalPage!,
          currentPage: search.page));
    } else {
      emit(ServiceBuyLoadFailed(apiResponse.msg!));
    }
  }

  selectService(
      {required ServiceBuy serviceBuy, required ServiceBuyLoadSuccess state}) {
    if (isClosed) return;
    emit(ServiceBuyLoadSuccess(
        list: state.list,
        totalPage: state.totalPage,
        currentPage: state.currentPage,
        selected: serviceBuy));
  }
}
