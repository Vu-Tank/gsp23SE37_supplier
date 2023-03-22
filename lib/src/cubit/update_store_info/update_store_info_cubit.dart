import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/store.dart';
import 'package:gsp23se37_supplier/src/repositpries/store_repositories.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/api_response.dart';

part 'update_store_info_state.dart';

class UpdateStoreInfoCubit extends Cubit<UpdateStoreInfoState> {
  UpdateStoreInfoCubit() : super(UpdateStoreInfoInitial());
  updateImage({required Store store, required String token}) async {
    if (isClosed) return;
    emit(UpdateStoreInfoLoading());
    try {
      final ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        ApiResponse apiResponse = await StoreRepositories.storeUpdateInfo(
            storeID: store.storeID, token: token, file: image);
        if (apiResponse.isSuccess!) {
          if (isClosed) return;
        } else {
          if (isClosed) return;
        }
      } else {
        if (isClosed) return;
        emit(const UpdateStoreInfoFailed('Không có hình ảnh được chọn'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(const UpdateStoreInfoFailed('Không có hình ảnh được chọn'));
    }
  }

  updateStoreName(
      {required Store store,
      required String value,
      required String token}) async {
    if (isClosed) return;
    emit(UpdateStoreInfoLoading());
    ApiResponse apiResponse = await StoreRepositories.storeUpdateInfo(
        storeID: store.storeID, token: token, storeName: value);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateStoreInfoSuccess(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(UpdateStoreInfoFailed(apiResponse.msg!));
    }
  }
}
