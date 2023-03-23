part of 'all_order_bloc.dart';

abstract class AllOrderState extends Equatable {
  const AllOrderState();

  @override
  List<Object?> get props => [];
}

class AllOrderInitial extends AllOrderState {}

class AllOrderLoading extends AllOrderState {}

class AllOrderLoaded extends AllOrderState {
  final List<Order> listOrder;
  final int currentPage;
  final int totalPage;
  final Order? selected;
  const AllOrderLoaded(
      {required this.listOrder,
      required this.currentPage,
      required this.totalPage,
      this.selected});
  @override
  // TODO: implement props
  List<Object?> get props => [listOrder, currentPage, totalPage, selected];
}

class AllOrderLoadFailed extends AllOrderState {
  final String msg;
  final OrderSearch orderSearch;
  const AllOrderLoadFailed({required this.msg, required this.orderSearch});
  @override
  List<Object> get props => [msg, orderSearch];
}
