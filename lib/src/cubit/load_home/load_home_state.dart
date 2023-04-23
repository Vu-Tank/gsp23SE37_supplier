part of 'load_home_cubit.dart';

abstract class LoadHomeState extends Equatable {
  const LoadHomeState();

  @override
  List<Object> get props => [];
}

class LoadHomeInitial extends LoadHomeState {}

class LoadHomeSuccess extends LoadHomeState {
  final Store store;

  const LoadHomeSuccess(this.store);
  @override
  // TODO: implement props
  List<Object> get props => [store];
}

class Loading extends LoadHomeState {}

class Failed extends LoadHomeState {
  final String msg;
  const Failed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
