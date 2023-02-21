import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/address/district.dart';
import '../../model/api_response.dart';
import '../../repositpries/address_repositories.dart';

part 'district_state.dart';

class DistrictCubit extends Cubit<DistrictState> {
  DistrictCubit() : super(DistrictInitial());
  selectedProvince(String provinceId) async {
    emit(DistrictLoading());
    ApiResponse apiResponse = await AddressRepository.getDistrict(provinceId);
    if (apiResponse.isSuccess!) {
      emit(DistrictLoaded(apiResponse.data));
    } else {
      emit(DistrictError(apiResponse.msg!));
    }
  }
}
