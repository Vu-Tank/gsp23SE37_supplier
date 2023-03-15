part of 'order_ticket_cubit.dart';

abstract class OrderTicketState extends Equatable {
  const OrderTicketState();

  @override
  List<Object> get props => [];
}

class OrderTicketInitial extends OrderTicketState {}

class OrderTicketLoading extends OrderTicketState {}

class OrderTicketLoaded extends OrderTicketState {
  final String base64;
  const OrderTicketLoaded(this.base64);
  @override
  // TODO: implement props
  List<Object> get props => [base64];
}

class OrderTicketFailed extends OrderTicketState {
  final String msg;
  const OrderTicketFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
