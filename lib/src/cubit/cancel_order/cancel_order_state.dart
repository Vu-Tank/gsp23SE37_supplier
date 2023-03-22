part of 'cancel_order_cubit.dart';

abstract class CancelOrderState extends Equatable {
  const CancelOrderState();

  @override
  List<Object> get props => [];
}

class CancelOrderInitial extends CancelOrderState {}

class CancelOrderSuccess extends CancelOrderState {}

class CancelOrderLoading extends CancelOrderState {}

class CancelOrderFailed extends CancelOrderState {
  final String msg;
  const CancelOrderFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
