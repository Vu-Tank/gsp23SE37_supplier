import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/address/district.dart';
import '../../model/address/goong_address.dart';
import '../../model/address/province.dart';
import '../../model/address/ward.dart';
import '../../model/api_response.dart';
import '../../model/user.dart';
import '../../model/validation_item.dart';
import '../../repositpries/address_repositories.dart';
import '../../repositpries/goong_repositories.dart';
import '../../repositpries/user_repositories.dart';
import '../../utils/app_constants.dart';
import '../../utils/utils.dart';
import '../../utils/validations.dart';

part 'register_supplier_event.dart';
part 'register_supplier_state.dart';

class RegisterSupplierBloc
    extends Bloc<RegisterSupplierEvent, RegisterSupplierState> {
  static final List<String> _gender = ['Khác', 'Nam', 'Nữ'];
  RegisterSupplierBloc() : super(RegisterSupplierloading()) {
    on<RegisterSupplierInit>(
      (event, emit) async {
        emit(RegisterSupplierloading());
        try {
          await AddressRepository.getProvince().then((value) {
            emit(RegisterSupplierInitial.fromOldState(state,
                genders: _gender,
                provinces: value.data,
                gender: _gender.first,
                province: (value.data as List).first));
          });
        } catch (e) {
          emit(RegisterSupplierFailed.fromOldState(state, msg: e.toString()));
        }
      },
    );
    on<RegisterSupplierPressed>((event, emit) async {
      emit(RegisterSuppliering.fromOldState(state));
      bool check = true;
      ValidationItem fullName = Validations.validUserName(event.fullName);
      if (fullName.error != null) check = false;
      ValidationItem email = Validations.valEmail(event.email);
      if (email.error != null) check = false;
      ValidationItem address = Validations.valAddressContext(event.address);
      if (address.error != null) check = false;
      ValidationItem dob = Validations.valDOB(event.dob);
      if (dob.error != null) check = false;
      ValidationItem province = Validations.valProvince(event.province);
      if (province.error != null) check = false;
      ValidationItem district = Validations.valDistrict(event.district);
      if (district.error != null) check = false;
      ValidationItem ward = Validations.valWard(event.ward);
      if (ward.error != null) check = false;
      ValidationItem isAgree = Validations.valAgree(event.isAgree);
      if (isAgree.error != null) check = false;
      if (check) {
        try {
          String? fcm = await FirebaseMessaging.instance.getToken();
          if (fcm == null) {
            throw Exception('Không thể lấy mã thông báo');
          }
          String? placeID = await GoongRepositories().getPlaceIdFromText(
              '${event.address}, ${event.province.value}, ${event.district!.value}, ${event.ward!.value}');
          if (placeID == null) throw Exception('Không thể lấy địa chỉ');
          GoongAddress? goongAddress =
              await GoongRepositories().getPlace(placeID);
          if (goongAddress == null) throw Exception('Không thể lấy địa chỉ');
          double lat = goongAddress.lat;
          double lng = goongAddress.lng;
          ApiResponse apiResponse = await UserRepositories.supplierRegister(
              token: event.token,
              fullName: fullName.value,
              email: email.value,
              phone: Utils.convertToDB(event.phone),
              imageName: 'defaultAvatar',
              imagepath: AppConstants.defaultAvatar,
              contextAddress: address.value,
              dateOfBirth: Utils.convertDateTimeToString(event.dob!),
              gender: event.gender,
              latitude: lat,
              longitude: lng,
              province: event.province.value,
              district: event.district!.value,
              ward: event.ward!.value,
              firebaseID: event.uid,
              fcMFirebase: fcm);
          if (apiResponse.isSuccess!) {
            User user = apiResponse.data as User;
            event.onSuccess(user);
          } else {
            emit(RegisterSupplierFailed.fromOldState(state,
                msg: apiResponse.msg));
          }
        } catch (e) {
          log(e.toString());
          emit(RegisterSupplierFailed.fromOldState(state, msg: e.toString()));
        }
      } else {
        emit(RegisterSupplierFailed.fromOldState(state,
            fullNameError: fullName.error,
            emailError: email.error,
            dobError: dob.error,
            addressError:
                province.error ?? district.error ?? ward.error ?? address.error,
            agreeError: isAgree.error));
      }
    });
  }
}
