part of 'order_ship_cubit.dart';

abstract class OrderShipState extends Equatable {
  const OrderShipState();

  @override
  List<Object> get props => [];
}

class OrderShipInitial extends OrderShipState {}

class OrderShiploading extends OrderShipState {}

class OrderShipLoadFailed extends OrderShipState {
  final String msg;
  const OrderShipLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class OrderShipLoadSuccess extends OrderShipState {
  final OrderShipStatus orderShipStatus;
  const OrderShipLoadSuccess(this.orderShipStatus);
  @override
  // TODO: implement props
  List<Object> get props => [orderShipStatus];
}
