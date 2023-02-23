part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> list;
  final Category selected;
  final SubCategory? subCategory;
  const CategoryLoaded(
      {required this.list, required this.selected, this.subCategory});

  @override
  // TODO: implement props
  List<Object?> get props => [list, selected, subCategory];
}

class CategoryLoadFailed extends CategoryState {
  final String msg;
  const CategoryLoadFailed(this.msg);
  @override
  // TODO: implement props
  List<Object> get props => [msg];
}
