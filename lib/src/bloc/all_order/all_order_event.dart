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
