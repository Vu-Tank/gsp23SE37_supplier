part of 'page_seleted_cubit.dart';

abstract class PageSeletedState extends Equatable {
  const PageSeletedState({this.index});
  final int? index;

  @override
  List<Object?> get props => [index];
}

class PageSeletedInitial extends PageSeletedState {
  const PageSeletedInitial() : super(index: null);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PageSelectedSuccess extends PageSeletedState {
  const PageSelectedSuccess(int? selectedIndex) : super(index: selectedIndex);
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
