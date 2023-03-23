import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';
import 'package:gsp23se37_supplier/src/utils/utils.dart';
import 'package:image_picker_web/image_picker_web.dart';
// ignore: avoid_web_libraries_in_flutter
import '../../repositpries/firebase_storage.dart';

part 'order_packing_video_state.dart';

class OrderPackingVideoCubit extends Cubit<OrderPackingVideoState> {
  OrderPackingVideoCubit() : super(OrderPackingVideoInitial());
  pickVideo({required String token, required int orderID}) async {
    if (isClosed) return;
    emit(OrderPackingVideoLoading());
    try {
      // FilePickerResult? result =
      //     await FilePicker.platform.pickFiles(type: FileType.video);

      // if (result != null) {
      // PlatformFile file = result.files.first;
      // var data = file.bytes;
      Uint8List? videoData = await ImagePickerWeb.getVideoAsBytes();
      if (videoData != null) {
        String? url = await FirebaseStorageService()
            .uploadFileVideo(videoData, Utils.createFile());
        if (url != null) {
          ApiResponse apiResponse = await OrderRepositories.updatePakingLink(
              token: token, orderID: orderID, url: url);
          if (apiResponse.isSuccess!) {
            if (isClosed) return;
            emit(OrderPackingVideoUpLoaded());
          } else {
            if (isClosed) return;
            emit(OrderPackingVideoLoadFailed(apiResponse.msg!));
          }
        } else {
          if (isClosed) return;
          emit(const OrderPackingVideoLoadFailed('Lỗi chọn lại'));
        }
      } else {
        if (isClosed) return;
        emit(const OrderPackingVideoLoadFailed('Chọn Video'));
      }
      // } else {
      //   if (isClosed) return;
      //   emit(const OrderPackingVideoLoadFailed('Chọn Video'));
      // }
    } catch (e) {
      if (isClosed) return;
      emit(OrderPackingVideoLoadFailed(e.toString()));
    }
  }
}
