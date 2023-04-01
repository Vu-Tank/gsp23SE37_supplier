import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';

import '../../model/order/order_ship_status.dart';

part 'order_ship_state.dart';

class OrderShipCubit extends Cubit<OrderShipState> {
  OrderShipCubit() : super(OrderShipInitial());
  loadOrderShipStatus(
      {required int? orderID,
      required String token,
      required int? serviceID}) async {
    if (isClosed) return;
    emit(OrderShiploading());
    ApiResponse apiResponse = await OrderRepositories.getOrderShipStatus(
        serviceID: serviceID, orderID: orderID, token: token);
    if (apiResponse.isSuccess!) {
      OrderShipStatus orderShipStatus = apiResponse.data;
      orderShipStatus.shipStatusModels.sort(
        (a, b) => b.create_Date.compareTo(a.create_Date),
      );
      if (isClosed) return;
      emit(OrderShipLoadSuccess(orderShipStatus));
    } else {
      if (isClosed) return;
      emit(OrderShipLoadFailed(apiResponse.msg!));
    }
  }
}
