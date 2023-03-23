part of 'service_activity_cubit.dart';

abstract class ServiceActivityState extends Equatable {
  const ServiceActivityState();

  @override
  List<Object> get props => [];
}

class ServiceActivityInitial extends ServiceActivityState {}

class ServiceActiviting extends ServiceActivityState {}

class ServiceActivityFailed extends ServiceActivityState {
  final String msg;
  const ServiceActivityFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}

class ServiceActivitySuccess extends ServiceActivityState {}
