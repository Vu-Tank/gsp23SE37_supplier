part of 'lwh_unit_cubit.dart';

abstract class LwhUnitState extends Equatable {
  final String lwhUnit;
  const LwhUnitState(this.lwhUnit);

  @override
  List<Object?> get props => [lwhUnit];
}

class LwhUnitInitial extends LwhUnitState {
  LwhUnitInitial() : super(AppConstants.listLwhtUnit.first);
  @override
  List<Object?> get props => [];
}

class LwhUnitSeleted extends LwhUnitState {
  const LwhUnitSeleted(String lwhUnit) : super(lwhUnit);
  @override
  // TODO: implement props
  List<Object> get props => [lwhUnit];
}
