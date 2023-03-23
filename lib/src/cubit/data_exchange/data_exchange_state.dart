part of 'data_exchange_cubit.dart';

abstract class DataExchangeState extends Equatable {
  const DataExchangeState();

  @override
  List<Object?> get props => [];
}

class DataExchangeInitial extends DataExchangeState {}

class DataExchangeLoading extends DataExchangeState {}

class DataExchangeFailed extends DataExchangeState {
  final String msg;
  const DataExchangeFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class DataExchangeSuccess extends DataExchangeState {
  final List<DataExchange> list;
  final int currentPage;
  final int totalPage;
  final DataExchange? selected;
  const DataExchangeSuccess(
      {required this.list,
      required this.currentPage,
      required this.totalPage,
      this.selected});
  @override
  // TODO: implement props
  List<Object?> get props => [list, currentPage, totalPage, selected];
}
