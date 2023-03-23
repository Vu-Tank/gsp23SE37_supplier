part of 'service_cancel_cubit.dart';

abstract class ServiceCancelState extends Equatable {
  const ServiceCancelState();

  @override
  List<Object> get props => [];
}

class ServiceCancelInitial extends ServiceCancelState {}

class ServiceCanceling extends ServiceCancelState {}

class ServiceCancelFailed extends ServiceCancelState {
  final String msg;
  const ServiceCancelFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class ServiceCancelSuccess extends ServiceCancelState {}
