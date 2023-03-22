part of 'update_supplier_info_cubit.dart';

abstract class UpdateSupplierInfoState extends Equatable {
  const UpdateSupplierInfoState();

  @override
  List<Object> get props => [];
}

class UpdateSupplierInfoInitial extends UpdateSupplierInfoState {}

class UpdateSupplierInfoLoading extends UpdateSupplierInfoState {}

class UpdateSupplierInfoFailed extends UpdateSupplierInfoState {
  final String msg;
  const UpdateSupplierInfoFailed(this.msg);
  @override
  List<Object> get props => [msg];
}

class UpdateSupplierInfoSuccess extends UpdateSupplierInfoState {
  final User user;
  const UpdateSupplierInfoSuccess(this.user);
  @override
  // TODO: implement props
  List<Object> get props => [user];
}
