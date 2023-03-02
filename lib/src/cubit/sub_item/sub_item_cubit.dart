import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/sub_item_request.dart';
import 'package:image_picker/image_picker.dart';

part 'sub_item_state.dart';

class SubItemCubit extends Cubit<SubItemState> {
  SubItemCubit()
      : super(SubItemState(listSub: [
          SubItemRequest(
              subName: TextEditingController(),
              subPrice: TextEditingController(),
              subAmount: TextEditingController())
        ]));
  addSubItem() {
    emit(SubItemLoading(listSub: state.listSub));
    List<SubItemRequest> list = state.listSub;
    list.add(SubItemRequest(
        subName: TextEditingController(),
        subPrice: TextEditingController(),
        subAmount: TextEditingController()));
    emit(SubItemState(listSub: list));
  }

  deleteSubItem({required int index}) {
    emit(SubItemLoading(listSub: state.listSub));
    List<SubItemRequest> list = state.listSub;
    list.removeAt(index);
    emit(SubItemState(listSub: list));
  }

  pickImage({required int index}) async {
    if (isClosed) return;
    emit(SubItemLoading(listSub: state.listSub));
    try {
      final ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var data = await image.readAsBytes();
        List<SubItemRequest> list = state.listSub;
        list[index].data = data;
        list[index].image = image;
        if (isClosed) return;
        emit(SubItemState(listSub: list));
      } else {
        if (isClosed) return;
        emit(SubItemPickImageFailed(
            index: index,
            msg: 'Không có hình ảnh được chọn',
            listSub: state.listSub));
      }
    } catch (e) {
      if (isClosed) return;
      emit(SubItemPickImageFailed(
          index: index, msg: e.toString(), listSub: state.listSub));
    }
  }

  resetSubItem() {
    emit(SubItemLoading(listSub: state.listSub));
    List<SubItemRequest> list = state.listSub;
    list.clear();
    list.add(SubItemRequest(
        subName: TextEditingController(),
        subPrice: TextEditingController(),
        subAmount: TextEditingController()));
    emit(SubItemState(listSub: list));
  }
}
