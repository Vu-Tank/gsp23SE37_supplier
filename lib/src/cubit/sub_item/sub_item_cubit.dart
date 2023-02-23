import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/sub_item_request.dart';

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
    log(list.length.toString());
    emit(SubItemState(listSub: list));
  }
}
