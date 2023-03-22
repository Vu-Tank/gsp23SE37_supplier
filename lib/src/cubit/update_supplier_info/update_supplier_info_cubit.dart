import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/repositpries/user_repositories.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/address/address.dart';
import '../../model/address/goong_address.dart';
import '../../repositpries/goong_repositories.dart';

part 'update_supplier_info_state.dart';

class UpdateSupplierInfoCubit extends Cubit<UpdateSupplierInfoState> {
  UpdateSupplierInfoCubit() : super(UpdateSupplierInfoInitial());
  updateImage({required User user}) async {
    if (isClosed) return;
    emit(UpdateSupplierInfoLoading());
    try {
      final ImagePicker picker = ImagePicker();

      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // var data = await image.readAsBytes();
        ApiResponse apiResponse = await UserRepositories.updateImage(
            userID: user.userID, file: image, token: user.token);
        if (apiResponse.isSuccess!) {
          if (isClosed) return;
          emit(UpdateSupplierInfoSuccess(apiResponse.data));
        } else {
          if (isClosed) return;
          emit(UpdateSupplierInfoFailed(apiResponse.msg!));
        }
      } else {
        if (isClosed) return;
        emit(const UpdateSupplierInfoFailed('Không có hình ảnh được chọn'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(const UpdateSupplierInfoFailed('Không có hình ảnh được chọn'));
    }
  }

  updateName({required User user, required String name}) async {
    if (isClosed) return;
    emit(UpdateSupplierInfoLoading());
    ApiResponse apiResponse = await UserRepositories.updateUserName(
        userName: name, token: user.token, userId: user.userID);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateSupplierInfoSuccess(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(UpdateSupplierInfoFailed(apiResponse.msg!));
    }
  }

  updateEmail({required User user, required String email}) async {
    if (isClosed) return;
    emit(UpdateSupplierInfoLoading());
    ApiResponse apiResponse = await UserRepositories.updateUserEmail(
        email: email, token: user.token, userId: user.userID);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateSupplierInfoSuccess(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(UpdateSupplierInfoFailed(apiResponse.msg!));
    }
  }

  updateGender({required User user, required String gender}) async {
    if (isClosed) return;
    emit(UpdateSupplierInfoLoading());
    ApiResponse apiResponse = await UserRepositories.updateUserGender(
        gender: gender, token: user.token, userId: user.userID);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateSupplierInfoSuccess(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(UpdateSupplierInfoFailed(apiResponse.msg!));
    }
  }

  updateDOB({required User user, required String dob}) async {
    if (isClosed) return;
    emit(UpdateSupplierInfoLoading());
    ApiResponse apiResponse = await UserRepositories.updateUserDOB(
        dob: dob, token: user.token, userId: user.userID);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(UpdateSupplierInfoSuccess(apiResponse.data));
    } else {
      if (isClosed) return;
      emit(UpdateSupplierInfoFailed(apiResponse.msg!));
    }
  }

  updateAddress({required User user, required Adderss address}) async {
    if (isClosed) return;
    emit(UpdateSupplierInfoLoading());
    String? placeID = await GoongRepositories().getPlaceIdFromText(
        '${address.context}, ${address.ward}, ${address.district}, ${address.province}');
    if (placeID == null) {
      if (isClosed) return;
      emit(const UpdateSupplierInfoFailed('Không thể lấy địa chỉ'));
    } else {
      GoongAddress? goongAddress = await GoongRepositories().getPlace(placeID);
      if (goongAddress == null) {
        if (isClosed) return;
        emit(const UpdateSupplierInfoFailed('Không thể lấy địa chỉ'));
      } else {
        address.latitude = goongAddress.lat;
        address.longitude = goongAddress.lng;

        ApiResponse apiResponse = await UserRepositories.updateUserAddress(
            address: address, token: user.token, userId: user.userID);
        if (apiResponse.isSuccess!) {
          if (isClosed) return;

          emit(UpdateSupplierInfoSuccess(
              user.copyWith(addresses: [apiResponse.data])));
        } else {
          if (isClosed) return;
          emit(UpdateSupplierInfoFailed(apiResponse.msg!));
        }
      }
    }
  }
}
