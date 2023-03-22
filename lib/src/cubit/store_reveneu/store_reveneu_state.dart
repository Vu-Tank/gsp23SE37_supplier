part of 'store_reveneu_cubit.dart';

abstract class StoreReveneuState extends Equatable {
  const StoreReveneuState();

  @override
  List<Object?> get props => [];
}

class StoreReveneuInitial extends StoreReveneuState {}

class StoreReveneuLoading extends StoreReveneuState {}

class StoreReveneuLoadFailed extends StoreReveneuState {
  final String msg;
  const StoreReveneuLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}

class StoreReveneuLoaded extends StoreReveneuState {
  final List<Reveneu> list;
  final int? time;
  const StoreReveneuLoaded({required this.list, this.time});
  @override
  // TODO: implement props
  List<Object?> get props => [list, time];
}
