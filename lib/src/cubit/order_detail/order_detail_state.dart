part of 'order_detail_cubit.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

class OrderDetailInitial extends OrderDetailState {}

class OrderDetailLoading extends OrderDetailState {}

class OrderDetailLoaded extends OrderDetailState {
  final Order order;
  const OrderDetailLoaded(this.order);
  @override
  // TODO: implement props
  List<Object> get props => [order];
}

class OrderDetailLoadFailed extends OrderDetailState {
  final String msg;
  final int orderID;
  const OrderDetailLoadFailed({required this.msg, required this.orderID});
  @override
  // TODO: implement props
  List<Object> get props => [msg, orderID];
}
