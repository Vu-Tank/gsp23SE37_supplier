import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/order/order.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitial());
  loadOrderDetail({required Order order, required String token}) async {
    if (isClosed) return;
    emit(OrderDetailLoading());
    if (isClosed) return;
    emit(OrderDetailLoaded(order));
    // ApiResponse apiResponse =
    //     await OrderRepositories.getOrderInfo(orderID: orderID, token: token);
    // if (apiResponse.isSuccess!) {
    //   if (isClosed) return;
    //   emit(OrderDetailLoaded(apiResponse.data));
    // } else {
    //   if (isClosed) return;
    //   emit(OrderDetailLoadFailed(msg: apiResponse.msg!, orderID: orderID));
    // }
  }

  reset() {
    if (isClosed) return;
    log("message");
    emit(OrderDetailInitial());
  }
}
