import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/utils/app_constants.dart';

part 'weight_unit_state.dart';

class WeightUnitCubit extends Cubit<WeightUnitState> {
  WeightUnitCubit() : super(WeightUnitInitial());
  selectWeightUnit(String value) {
    if (isClosed) return;
    emit(WeightUnitSelected(value));
  }
}
