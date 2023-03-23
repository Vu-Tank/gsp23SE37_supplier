part of 'service_buy_cubit.dart';

abstract class ServiceBuyState extends Equatable {
  const ServiceBuyState();

  @override
  List<Object?> get props => [];
}

class ServiceBuyInitial extends ServiceBuyState {}

class ServiceBuyLoading extends ServiceBuyState {}

class ServiceBuyLoadFailed extends ServiceBuyState {
  final String msg;
  const ServiceBuyLoadFailed(this.msg);

  @override
  List<Object?> get props => [msg];
}

class ServiceBuyLoadSuccess extends ServiceBuyState {
  final List<ServiceBuy> list;
  final int totalPage;
  final int currentPage;
  final ServiceBuy? selected;
  const ServiceBuyLoadSuccess(
      {required this.list,
      required this.totalPage,
      required this.currentPage,
      this.selected});
  @override
  List<Object?> get props => [list, totalPage, currentPage, selected];
}
