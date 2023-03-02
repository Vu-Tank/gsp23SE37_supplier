part of 'items_block_bloc.dart';

abstract class ItemsBlockState extends Equatable {
  const ItemsBlockState();

  @override
  List<Object> get props => [];
}

class ItemsBlockInitial extends ItemsBlockState {}

class ItemsBlockLoading extends ItemsBlockState {}

class ItemsBlockLoadSuccess extends ItemsBlockState {
  final List<Item> list;
  final int currentPage;
  final int totalPage;
  const ItemsBlockLoadSuccess(
      {required this.list, required this.currentPage, required this.totalPage});
  @override
  // TODO: implement props
  List<Object> get props => [list, currentPage, totalPage];
}

class ItemsBlockLoadFailed extends ItemsBlockState {
  final String msg;
  const ItemsBlockLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
