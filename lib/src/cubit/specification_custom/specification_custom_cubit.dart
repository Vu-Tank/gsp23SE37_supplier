import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'specification_custom_state.dart';

class SpecificationCustomCubit extends Cubit<SpecificationCustomState> {
  SpecificationCustomCubit() : super(SpecificationCustomInitial());
  addSpecifi(String specifiName, TextEditingController specifiCusController) {
    if (isClosed) return;
    emit(SpecificationCustomLoading.formOldState(state));
    final List<String> listspecifiCusNames = state.listspecifiCusName;
    final List<TextEditingController> listspecifiCusControllers =
        state.listspecifiCusController;
    listspecifiCusNames.add(specifiName);
    listspecifiCusControllers.add(specifiCusController);
    if (isClosed) return;
    emit(SpecificationCustomAddSuccess(
        listspecifiCusControllers: listspecifiCusControllers,
        listspecifiCusNames: listspecifiCusNames));
  }

  deleteSpecifi(int index) {
    if (isClosed) return;
    emit(SpecificationCustomLoading.formOldState(state));
    emit(SpecificationCustomLoading.formOldState(state));
    final List<String> listspecifiCusNames = state.listspecifiCusName;
    final List<TextEditingController> listspecifiCusControllers =
        state.listspecifiCusController;
    listspecifiCusNames.removeAt(index);
    listspecifiCusControllers.removeAt(index);
    if (isClosed) return;
    emit(SpecificationCustomAddSuccess(
        listspecifiCusControllers: listspecifiCusControllers,
        listspecifiCusNames: listspecifiCusNames));
  }
}
