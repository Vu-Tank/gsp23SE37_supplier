part of 'item_pending_bloc.dart';

abstract class ItemPendingEvent extends Equatable {
  const ItemPendingEvent();

  @override
  List<Object> get props => [];
}

class ItemPendingLoad extends ItemPendingEvent {
  final String token;
  final int storeId;
  final int page;
  const ItemPendingLoad(
      {required this.token, required this.storeId, required this.page});
  @override
  // TODO: implement props
  List<Object> get props => [token, storeId, page];
}
