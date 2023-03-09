part of 'weight_unit_cubit.dart';

abstract class WeightUnitState extends Equatable {
  final String weightUnit;
  const WeightUnitState(this.weightUnit);

  @override
  List<Object?> get props => [weightUnit];
}

class WeightUnitInitial extends WeightUnitState {
  WeightUnitInitial() : super(AppConstants.listWeightUnit.first);
  @override
  List<Object?> get props => [];
}

class WeightUnitSelected extends WeightUnitState {
  const WeightUnitSelected(String weightUnit) : super(weightUnit);
  @override
  // TODO: implement props
  List<Object> get props => [weightUnit];
}
