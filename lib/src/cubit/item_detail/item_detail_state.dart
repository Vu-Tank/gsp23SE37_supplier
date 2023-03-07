part of 'item_detail_cubit.dart';

abstract class ItemDetailState extends Equatable {
  const ItemDetailState();

  @override
  List<Object> get props => [];
}

class ItemDetailInitial extends ItemDetailState {}

class ItemDetailLoading extends ItemDetailState {}

class ItemDetailLoaded extends ItemDetailState {
  final ItemDetail itemDetail;
  const ItemDetailLoaded(this.itemDetail);
  @override
  // TODO: implement props
  List<Object> get props => [itemDetail];
}

class ItemDetailLoadFailed extends ItemDetailState {
  final String msg;
  const ItemDetailLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
