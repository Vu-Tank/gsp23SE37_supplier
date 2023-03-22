part of 'update_store_info_cubit.dart';

abstract class UpdateStoreInfoState extends Equatable {
  const UpdateStoreInfoState();

  @override
  List<Object> get props => [];
}

class UpdateStoreInfoInitial extends UpdateStoreInfoState {}

class UpdateStoreInfoLoading extends UpdateStoreInfoState {}

class UpdateStoreInfoFailed extends UpdateStoreInfoState {
  final String msg;
  const UpdateStoreInfoFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class UpdateStoreInfoSuccess extends UpdateStoreInfoState {
  final Store store;
  const UpdateStoreInfoSuccess(this.store);
  @override
  // TODO: implement props
  List<Object> get props => [store];
}
