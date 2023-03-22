part of 'all_item_bloc.dart';

abstract class AllItemState extends Equatable {
  const AllItemState();

  @override
  List<Object> get props => [];
}

class AllItemInitial extends AllItemState {}

class AllItemLoading extends AllItemState {}

class AllItemLoadSuccess extends AllItemState {
  final List<Item> list;
  final int currentPage;
  final int totalPage;
  const AllItemLoadSuccess(
      {required this.list, required this.currentPage, required this.totalPage});
  @override
  // TODO: implement props
  List<Object> get props => [list, currentPage, totalPage];
}

class AllItemLoadFailed extends AllItemState {
  final String msg;
  final ItemSearch search;
  const AllItemLoadFailed({required this.msg, required this.search});
  @override
  // TODO: implement props
  List<Object> get props => [msg, search];
}
