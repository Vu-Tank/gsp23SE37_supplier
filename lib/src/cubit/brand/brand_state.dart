part of 'brand_cubit.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<Brand> list;
  final Brand brand;
  const BrandLoaded({required this.list, required this.brand});

  @override
  List<Object> get props => [list, brand];
}

class BrandLoadFailed extends BrandState {
  final String msg;
  const BrandLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
