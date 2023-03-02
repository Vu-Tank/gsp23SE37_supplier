part of 'item_pending_bloc.dart';

abstract class ItemPendingState extends Equatable {
  const ItemPendingState();

  @override
  List<Object> get props => [];
}

class ItemPendingInitial extends ItemPendingState {}

class ItemPendingLoading extends ItemPendingState {}

class ItemPendingLoadSuccess extends ItemPendingState {
  final List<Item> list;
  final int currentPage;
  final int totalPage;
  const ItemPendingLoadSuccess(
      {required this.list, required this.currentPage, required this.totalPage});
  @override
  // TODO: implement props
  List<Object> get props => [list, currentPage, totalPage];
}

class ItemPendingLoadFailed extends ItemPendingState {
  final String msg;
  const ItemPendingLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
