part of 'store_withdrawal_cubit.dart';

abstract class StoreWithdrawalState extends Equatable {
  const StoreWithdrawalState();

  @override
  List<Object> get props => [];
}

class StoreWithdrawalInitial extends StoreWithdrawalState {}

class StoreWithdrawalLoading extends StoreWithdrawalState {}

class StoreWithdrawalLoadFailed extends StoreWithdrawalState {
  final String msg;
  const StoreWithdrawalLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class StoreWithdrawalSuccess extends StoreWithdrawalState {}
