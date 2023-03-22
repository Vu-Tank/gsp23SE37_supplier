part of 'update_subitem_cubit.dart';

abstract class UpdateSubitemState extends Equatable {
  const UpdateSubitemState();

  @override
  List<Object> get props => [];
}

class UpdateSubitemInitial extends UpdateSubitemState {}

class UpdateSubItemLoading extends UpdateSubitemState {}

class UpdateSubitemFailde extends UpdateSubitemState {
  final String msg;
  const UpdateSubitemFailde(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class UpdateSubitemSuccess extends UpdateSubitemState {}
