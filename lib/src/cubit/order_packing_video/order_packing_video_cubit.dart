import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';

import '../../repositpries/firebase_storage.dart';

part 'order_packing_video_state.dart';

class OrderPackingVideoCubit extends Cubit<OrderPackingVideoState> {
  OrderPackingVideoCubit() : super(OrderPackingVideoInitial());
  pickVideo({required String token, required int orderID}) async {
    if (isClosed) return;
    emit(OrderPackingVideoLoading());
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.video);

      if (result != null) {
        PlatformFile file = result.files.first;
        var data = file.bytes;
        if (data != null) {
          String? url =
              await FirebaseStorageService().uploadFileVideo(data, file.name);
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
      } else {
        if (isClosed) return;
        emit(const OrderPackingVideoLoadFailed('Chọn Video'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(OrderPackingVideoLoadFailed(e.toString()));
    }
  }
}
