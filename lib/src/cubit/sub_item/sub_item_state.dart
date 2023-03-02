// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sub_item_cubit.dart';

class SubItemState extends Equatable {
  final List<SubItemRequest> listSub;
  const SubItemState({
    required this.listSub,
  });

  @override
  List<Object> get props => [listSub];
}

class SubItemLoading extends SubItemState {
  const SubItemLoading({required super.listSub});
}

class SubItemPickImageFailed extends SubItemState {
  final int index;
  final String msg;
  const SubItemPickImageFailed(
      {required this.index, required this.msg, required super.listSub});
  @override
  // TODO: implement props
  List<Object> get props => [index, msg, listSub];
}
