import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/order/order.dart';
import 'package:gsp23se37_supplier/src/model/order/order_search.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';

part 'all_order_event.dart';
part 'all_order_state.dart';

class AllOrderBloc extends Bloc<AllOrderEvent, AllOrderState> {
  AllOrderBloc() : super(AllOrderInitial()) {
    on<AllOrderLoad>((event, emit) async {
      if (isClosed) return;
      emit(AllOrderLoading());
      ApiResponse apiResponse = await OrderRepositories.getOrders(
          orderSearch: event.orderSearch, token: event.token);
      if (apiResponse.isSuccess!) {
        if (isClosed) return;
        emit(AllOrderLoaded(
            listOrder: apiResponse.data,
            currentPage: event.orderSearch.page,
            totalPage: apiResponse.totalPage!));
      } else {
        if (isClosed) return;
        emit(AllOrderLoadFailed(
            msg: apiResponse.msg!, orderSearch: event.orderSearch));
      }
    });
  }
}
