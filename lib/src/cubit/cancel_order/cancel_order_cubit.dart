import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';

part 'cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  CancelOrderCubit() : super(CancelOrderInitial());
  cancelOrder(
      {required String reason,
      required int orderID,
      required String token}) async {
    if (isClosed) return;
    emit(CancelOrderLoading());
    ApiResponse apiResponse = await OrderRepositories.cancelOrder(
        orderID: orderID, token: token, reason: reason);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(CancelOrderSuccess());
    } else {
      if (isClosed) return;
      emit(CancelOrderFailed(apiResponse.msg!));
    }
  }
}
