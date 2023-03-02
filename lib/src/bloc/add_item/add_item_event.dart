// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_item_bloc.dart';

abstract class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}

class AddItemPressed extends AddItemEvent {
  final bool formVal;
  final String name;
  final String description;
  final String discount;
  final int storeID;
  final int subCategoryID;
  final List<XFile> listImage;
  // final List<XFile> listSubItemImage;
  final List<SubItemRequest> listSubItem;
  final List<SpecificationRequest> listSpecitication;
  final List<int> listModel;
  final List<SpecificationCustomRequest> listSpecificationCustom;
  final String token;
  const AddItemPressed({
    required this.formVal,
    required this.name,
    required this.description,
    required this.discount,
    required this.storeID,
    required this.subCategoryID,
    required this.listImage,
    required this.listSubItem,
    required this.listSpecitication,
    required this.listModel,
    required this.listSpecificationCustom,
    required this.token,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        formVal,
        name,
        description,
        discount,
        storeID,
        subCategoryID,
        listImage,
        listSpecitication,
        listModel,
        listSpecificationCustom,
        token
      ];
}
