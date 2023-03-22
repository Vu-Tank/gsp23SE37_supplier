part of 'cash_flow_cubit.dart';

abstract class CashFlowState extends Equatable {
  const CashFlowState();

  @override
  List<Object> get props => [];
}

class CashFlowInitial extends CashFlowState {}

class CashFlowLoading extends CashFlowState {}

class CashFlowLoadFailed extends CashFlowState {
  final String msg;
  const CashFlowLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class CashFlowLoaded extends CashFlowState {
  final List<CashFlow> list;
  final int totalPage;
  final int curentPage;
  const CashFlowLoaded(
      {required this.list, required this.curentPage, required this.totalPage});
  @override
  // TODO: implement props
  List<Object> get props => [list, curentPage, totalPage];
}
