part of 'add_item_bloc.dart';

abstract class AddItemState extends Equatable {
  const AddItemState();
  
  @override
  List<Object> get props => [];
}

class AddItemInitial extends AddItemState {}
