import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/address/district.dart';
import 'package:gsp23se37_supplier/src/model/address/province.dart';
import 'package:gsp23se37_supplier/src/model/address/ward.dart';

import '../../model/api_response.dart';
import '../../repositpries/address_repositories.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());
  loadAddress(
      {String? provinceName, String? districtName, String? WardName}) async {
    if (isClosed) return;
    emit(AddressLoadingProvince());
    ApiResponse apiResponse = await AddressRepository.getProvince();
    if (apiResponse.isSuccess!) {
      List<Province> provinces = apiResponse.data;
      Province provinceSelected = provinces.first;
      if (provinceName != null) {
        for (var province in provinces) {
          if (province.value == provinceName) {
            provinceSelected = province;
            break;
          }
        }
        apiResponse = await AddressRepository.getDistrict(provinceSelected.key);
        if (apiResponse.isSuccess!) {
          List<District> districts = apiResponse.data;
          District districtSelected = districts.first;
          if (districtName != null) {
            for (var dictrict in districts) {
              if (dictrict.value == districtName) {
                districtSelected = dictrict;
                break;
              }
            }
            apiResponse = await AddressRepository.getWard(districtSelected.key);
            if (apiResponse.isSuccess!) {
              List<Ward> wards = apiResponse.data;
              Ward wardSelected = wards.first;
              if (WardName != null) {
                for (var ward in wards) {
                  if (ward.value == WardName) {
                    wardSelected = ward;
                    break;
                  }
                }
              }
              if (isClosed) return;
              emit(AddressLoaded(
                  provinces: provinces,
                  province: provinceSelected,
                  districts: districts,
                  district: districtSelected,
                  wards: wards,
                  ward: wardSelected));
            } else {
              if (isClosed) return;
              emit(AddressLoadFailed(apiResponse.msg!));
              return;
            }
          }
          if (isClosed) return;
          emit(AddressLoaded(
              provinces: provinces,
              province: provinceSelected,
              districts: districts,
              district: districtSelected));
        } else {
          if (isClosed) return;
          emit(AddressLoadFailed(apiResponse.msg!));
          return;
        }
      }
      if (isClosed) return;
      emit(AddressLoaded(provinces: provinces, province: provinceSelected));
    } else {
      if (isClosed) return;
      emit(AddressLoadFailed(apiResponse.msg!));
    }
  }
}
