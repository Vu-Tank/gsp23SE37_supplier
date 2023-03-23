part of 'item_hot_cubit.dart';

abstract class ItemHotState extends Equatable {
  const ItemHotState();

  @override
  List<Object> get props => [];
}

class ItemHotInitial extends ItemHotState {}

class ItemHotLoading extends ItemHotState {}

class ItemHotLoaded extends ItemHotState {
  final List<Item> list;
  const ItemHotLoaded(this.list);
  @override
  List<Object> get props => [];
}

class ItemHotFailed extends ItemHotState {
  final String msg;
  const ItemHotFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
