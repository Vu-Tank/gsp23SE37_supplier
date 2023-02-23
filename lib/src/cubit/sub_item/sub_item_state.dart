// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sub_item_cubit.dart';

class SubItemState extends Equatable {
  List<SubItemRequest> listSub;
  SubItemState({
    required this.listSub,
  });

  @override
  List<Object> get props => [listSub];
}

class SubItemLoading extends SubItemState {
  SubItemLoading({required super.listSub});
  @override
  List<Object> get props => [listSub];
}
