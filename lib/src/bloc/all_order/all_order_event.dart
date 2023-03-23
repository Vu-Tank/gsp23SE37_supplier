part of 'all_order_bloc.dart';

abstract class AllOrderEvent extends Equatable {
  const AllOrderEvent();

  @override
  List<Object> get props => [];
}

class AllOrderLoad extends AllOrderEvent {
  final OrderSearch orderSearch;
  final String token;
  const AllOrderLoad({required this.orderSearch, required this.token});
  @override
  // TODO: implement props
  List<Object> get props => [orderSearch, token];
}

class OrderSelected extends AllOrderEvent {
  final Order order;
  final AllOrderLoaded state;
  const OrderSelected({required this.order, required this.state});
  @override
  // TODO: implement props
  List<Object> get props => [order, state];
}
