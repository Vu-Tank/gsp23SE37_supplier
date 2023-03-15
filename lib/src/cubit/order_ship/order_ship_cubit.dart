import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';

import '../../model/order/order_ship_status.dart';

part 'order_ship_state.dart';

class OrderShipCubit extends Cubit<OrderShipState> {
  OrderShipCubit() : super(OrderShipInitial());
  loadOrderShipStatus({required int orderID, required String token}) async {
    if (isClosed) return;
    emit(OrderShiploading());
    ApiResponse apiResponse = await OrderRepositories.getOrderShipStatus(
        orderID: orderID, token: token);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(OrderShipLoadSuccess(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(OrderShipLoadFailed(apiResponse.msg!));
    }
  }
}
