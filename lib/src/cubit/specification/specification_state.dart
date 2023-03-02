part of 'specification_cubit.dart';

abstract class SpecificationState extends Equatable {
  const SpecificationState();

  @override
  List<Object> get props => [];
}

class SpecificationInitial extends SpecificationState {}

class SpecificationLoading extends SpecificationState {}

class SpecificationLoaded extends SpecificationState {
  final List<Specification> list;
  const SpecificationLoaded(this.list);
  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class SpecificationLoadFailed extends SpecificationState {
  final String msg;
  const SpecificationLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
