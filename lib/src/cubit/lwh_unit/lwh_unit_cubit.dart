import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/utils/app_constants.dart';

part 'lwh_unit_state.dart';

class LwhUnitCubit extends Cubit<LwhUnitState> {
  LwhUnitCubit() : super(LwhUnitInitial());
  selectedLwhUnit(String lwhUnit) {
    if (isClosed) return;
    emit(LwhUnitSeleted(lwhUnit));
  }
}
