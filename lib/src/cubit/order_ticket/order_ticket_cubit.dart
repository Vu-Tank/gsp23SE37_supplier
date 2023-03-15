import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';

part 'order_ticket_state.dart';

class OrderTicketCubit extends Cubit<OrderTicketState> {
  OrderTicketCubit() : super(OrderTicketInitial());
  getTicker(
      {required int orderID,
      required String token,
      required Function onSuccess}) async {
    if (isClosed) return;
    emit(OrderTicketLoading());
    ApiResponse apiResponse =
        await OrderRepositories.getTicket(orderID: orderID, token: token);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(OrderTicketLoaded(apiResponse.data));
      onSuccess(apiResponse.data);
    } else {
      if (isClosed) return;
      emit(OrderTicketFailed(apiResponse.msg!));
    }
  }
}
