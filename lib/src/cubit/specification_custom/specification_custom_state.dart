part of 'specification_custom_cubit.dart';

abstract class SpecificationCustomState extends Equatable {
  final List<String> listspecifiCusName;
  final List<TextEditingController> listspecifiCusController;
  const SpecificationCustomState(
      {required this.listspecifiCusName,
      required this.listspecifiCusController});

  @override
  List<Object> get props => [listspecifiCusName, listspecifiCusController];
}

class SpecificationCustomInitial extends SpecificationCustomState {
  SpecificationCustomInitial()
      : super(listspecifiCusName: [], listspecifiCusController: []);
  @override
  List<Object> get props => [];
}

class SpecificationCustomLoading extends SpecificationCustomState {
  SpecificationCustomLoading.formOldState(SpecificationCustomState oldState)
      : super(
            listspecifiCusName: oldState.listspecifiCusName,
            listspecifiCusController: oldState.listspecifiCusController);
  @override
  List<Object> get props => [];
}

class SpecificationCustomAddSuccess extends SpecificationCustomState {
  final List<String> listspecifiCusNames;
  final List<TextEditingController> listspecifiCusControllers;
  const SpecificationCustomAddSuccess(
      {required this.listspecifiCusNames,
      required this.listspecifiCusControllers})
      : super(
            listspecifiCusName: listspecifiCusNames,
            listspecifiCusController: listspecifiCusControllers);
  @override
  List<Object> get props => [listspecifiCusNames, listspecifiCusControllers];
}
