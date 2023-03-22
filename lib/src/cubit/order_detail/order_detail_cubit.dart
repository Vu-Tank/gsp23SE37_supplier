import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/order/order.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitial());
  loadOrderDetail({required Order order, required String token}) async {
    if (isClosed) return;
    emit(OrderDetailLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (isClosed) return;
    emit(OrderDetailLoaded(order));
  }

  reset() {
    if (isClosed) return;
    emit(OrderDetailInitial());
  }
}
