part of 'items_block_bloc.dart';

abstract class ItemsBlockEvent extends Equatable {
  const ItemsBlockEvent();

  @override
  List<Object> get props => [];
}

class ItemsBlockLoad extends ItemsBlockEvent {
  final String token;
  final int storeId;
  final int page;
  const ItemsBlockLoad(
      {required this.token, required this.storeId, required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [token, storeId, page];
}
