import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/store.dart';
import 'package:gsp23se37_supplier/src/model/store_status.dart';
import 'package:gsp23se37_supplier/src/repositpries/store_repositories.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/address/address.dart';
import '../../model/address/goong_address.dart';
import '../../model/api_response.dart';
import '../../repositpries/goong_repositories.dart';

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
          emit(UpdateStoreInfoSuccess(apiResponse.data));
        } else {
          if (isClosed) return;
          emit(UpdateStoreInfoFailed(apiResponse.msg!));
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

  updateStoreEmail(
      {required Store store,
      required String value,
      required String token}) async {
    if (isClosed) return;
    emit(UpdateStoreInfoLoading());
    ApiResponse apiResponse = await StoreRepositories.storeUpdateInfo(
        storeID: store.storeID, token: token, email: value);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateStoreInfoSuccess(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(UpdateStoreInfoFailed(apiResponse.msg!));
    }
  }

  updateAddress(
      {required Adderss address,
      required Store store,
      required String token}) async {
    if (isClosed) return;
    emit(UpdateStoreInfoLoading());
    String? placeID = await GoongRepositories().getPlaceIdFromText(
        // '${address.context}, ${address.ward}, ${address.district}, ${address.province}');
        address.province);
    if (placeID == null) {
      if (isClosed) return;
      emit(const UpdateStoreInfoFailed('Không thể lấy địa chỉ'));
    } else {
      GoongAddress? goongAddress = await GoongRepositories().getPlace(placeID);
      if (goongAddress == null) {
        if (isClosed) return;
        emit(const UpdateStoreInfoFailed('Không thể lấy địa chỉ'));
      } else {
        address.latitude = goongAddress.lat;
        address.longitude = goongAddress.lng;

        ApiResponse apiResponse = await StoreRepositories.storeUpdateAddress(
            storeID: store.storeID, token: token, address: address);
        if (apiResponse.isSuccess!) {
          if (isClosed) return;

          emit(UpdateStoreInfoSuccess(
              store.copyWith(address: apiResponse.data)));
        } else {
          if (isClosed) return;
          emit(UpdateStoreInfoFailed(apiResponse.msg!));
        }
      }
    }
  }

  updateStatus(
      {required String token,
      required bool status,
      required Store store}) async {
    if (isClosed) return;
    emit(UpdateStoreInfoLoading());
    ApiResponse apiResponse;
    if (status) {
      apiResponse = await StoreRepositories.storeHidden(
          storeID: store.storeID, token: token);
    } else {
      apiResponse = await StoreRepositories.storeUnHidden(
          storeID: store.storeID, token: token);
    }
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateStoreInfoSuccess(store.copyWith(
          store_Status: (status)
              ? StoreStatus(item_StatusID: 4, statusName: 'Ẩn')
              : StoreStatus(item_StatusID: 1, statusName: "Hoạt động"))));
    } else {
      if (isClosed) return;
      emit(UpdateStoreInfoFailed(apiResponse.msg!));
    }
  }
}
