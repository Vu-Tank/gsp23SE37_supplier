part of 'all_item_bloc.dart';

abstract class AllItemEvent extends Equatable {
  const AllItemEvent();

  @override
  List<Object> get props => [];
}

class AllItemLoad extends AllItemEvent {
  final String token;
  final ItemSearch itemSearch;
  const AllItemLoad({required this.token, required this.itemSearch});
  @override
  // TODO: implement props
  List<Object> get props => [token, itemSearch];
}
