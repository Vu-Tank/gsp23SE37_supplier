import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/specification_request.dart';
import 'package:gsp23se37_supplier/src/model/sub_item_request.dart';
import 'package:gsp23se37_supplier/src/model/sub_item_request_data.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/api_response.dart';
import '../../model/specification_custom_request.dart';
import '../../repositpries/item_repositories.dart';

part 'add_item_event.dart';
part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  AddItemBloc() : super(AddItemInitial()) {
    on<AddItemPressed>((event, emit) async {
      if (isClosed) return;
      emit(AddIteming());
      bool check = event.formVal;
      if (event.listImage.isEmpty) {
        check = false;
      }
      List<String?>? subImageError = [];
      for (var element in event.listSubItem) {
        if (element.image == null) {
          subImageError.add('Vui lòng chọn ảnh');
          check = false;
        } else {
          subImageError.add(null);
        }
      }
      if (event.listModel.isEmpty) {
        check = false;
      }
      if (check) subImageError = null;
      if (check) {
        List<XFile> listSubItemImage = [];
        List<SubItemRequestData> listSubItem = [];
        for (var element in event.listSubItem) {
          listSubItemImage.add(element.image!);
          listSubItem.add(SubItemRequestData(
              sub_ItemName: element.subName.text.trim(),
              price: double.parse(element.subPrice.text
                  .replaceAll('VNĐ', '')
                  .replaceAll('.', '')
                  .trim()),
              amount: int.parse(element.subAmount.text.trim())));
        }
        ApiResponse apiResponse = await ItemRepositories.addItem(
            token: event.token,
            name: event.name,
            description: event.description,
            discount: double.parse(event.discount) * 0.01,
            storeID: event.storeID,
            subCategoryID: event.subCategoryID,
            listImage: event.listImage,
            listSubItemImage: listSubItemImage,
            listSubItem:
                List<String>.from(listSubItem.map((e) => e.toJson().toString()))
                    .toString()
                    .replaceAll(' {', '{'),
            listSpecitication: List<String>.from(
                    event.listSpecitication.map((e) => e.toJson().toString()))
                .toString()
                .replaceAll(' {', '{'),
            listModel: event.listModel.toString().replaceAll(' ', ''),
            listSpecificationCustom: List<String>.from(
                    event.listSpecificationCustom.map((e) => e.toJson().toString()))
                .toString()
                .replaceAll(' {', '{'));
        if (apiResponse.isSuccess!) {
          if (isClosed) return;
          emit(AddItemSuccess());
        } else {
          if (isClosed) return;
          emit(AddItemFailde(msg: apiResponse.msg));
        }
      } else {
        if (isClosed) return;
        emit(AddItemFailde(
            imageError: (event.listImage.isEmpty)
                ? 'Vui lòng chọn hình ảnh cho sản phẩm'
                : null,
            subImageError: subImageError,
            selectedModelError: (event.listModel.isEmpty)?'Vui lòng chọn phương tiện được hổ trợ':null));
      }
    });
  }
}
