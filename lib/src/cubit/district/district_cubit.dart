import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/address/district.dart';
import '../../model/api_response.dart';
import '../../repositpries/address_repositories.dart';

part 'district_state.dart';

class DistrictCubit extends Cubit<DistrictState> {
  DistrictCubit() : super(DistrictInitial());
  loadDistrict({required String provinceId, String? districtName}) async {
    if (isClosed) return;
    emit(DistrictLoading());
    ApiResponse apiResponse = await AddressRepository.getDistrict(provinceId);
    if (apiResponse.isSuccess!) {
      List<District> list = apiResponse.data;
      District selected = list.first;
      if (districtName != null) {
        for (var element in list) {
          if (element.value == districtName) {
            selected = element;
            break;
          }
        }
      }
      if (isClosed) return;
      emit(DistrictLoaded(districts: list, district: selected));
    } else {
      if (isClosed) return;
      emit(DistrictError(apiResponse.msg!));
    }
  }

  selectedDistrict({required List<District> list, required District district}) {
    if (isClosed) return;
    emit(DistrictLoading());
    if (isClosed) return;
    emit(DistrictLoaded(districts: list, district: district));
  }
}
