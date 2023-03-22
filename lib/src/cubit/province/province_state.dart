part of 'province_cubit.dart';

abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceLoaded extends ProvinceState {
  final List<Province> provinces;
  final Province province;
  const ProvinceLoaded({required this.provinces, required this.province});
  @override
  // TODO: implement props
  List<Object> get props => [provinces, province];
}

class ProvinceError extends ProvinceState {
  final String msg;
  const ProvinceError(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
