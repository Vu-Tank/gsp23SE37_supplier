// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_item_bloc.dart';

abstract class AddItemState extends Equatable {
  const AddItemState();

  @override
  List<Object?> get props => [];
}

class AddItemInitial extends AddItemState {}

class AddIteming extends AddItemState {}

class AddItemSuccess extends AddItemState {}

class AddItemFailde extends AddItemState {
  final String? msg;
  final String? imageError;
  final List<String?>? subImageError;
  const AddItemFailde({this.msg, this.imageError, this.subImageError});
  @override
  // TODO: implement props
  List<Object?> get props => [msg, imageError, subImageError];
}
