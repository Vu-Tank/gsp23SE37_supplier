part of 'store_withdrawal_request_cubit.dart';

abstract class StoreWithdrawalRequestState extends Equatable {
  const StoreWithdrawalRequestState();

  @override
  List<Object> get props => [];
}

class StoreWithdrawalRequestInitial extends StoreWithdrawalRequestState {}

class StoreWithdrawalRequestLoading extends StoreWithdrawalRequestState {}

class StoreWithdrawalRequestFailed extends StoreWithdrawalRequestState {
  final String msg;
  const StoreWithdrawalRequestFailed(this.msg);
  @override
  List<Object> get props => [msg];
}

class StoreWithdrawalRequestSuccess extends StoreWithdrawalRequestState {
  final List<Withdrawal> list;
  final int currentPage;
  final int totalPage;
  const StoreWithdrawalRequestSuccess(
      {required this.list, required this.currentPage, required this.totalPage});
  @override
  // TODO: implement props
  List<Object> get props => [list, currentPage, totalPage];
}
