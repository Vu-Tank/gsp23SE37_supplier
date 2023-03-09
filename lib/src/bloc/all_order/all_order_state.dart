part of 'all_order_bloc.dart';

abstract class AllOrderState extends Equatable {
  const AllOrderState();

  @override
  List<Object> get props => [];
}

class AllOrderInitial extends AllOrderState {}

class AllOrderLoading extends AllOrderState {}

class AllOrderLoaded extends AllOrderState {
  final List<Order> listOrder;
  final int currentPage;
  const AllOrderLoaded(this.listOrder, this.currentPage);
  @override
  // TODO: implement props
  List<Object> get props => [listOrder, currentPage];
}

class AllOrderLoadFailed extends AllOrderState {
  final String msg;
  const AllOrderLoadFailed(this.msg);
  @override
  List<Object> get props => [msg];
}
