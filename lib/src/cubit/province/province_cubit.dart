import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/address/province.dart';
import '../../model/api_response.dart';
import '../../repositpries/address_repositories.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  ProvinceCubit() : super(ProvinceInitial());
  loadProvince() async {
    emit(ProvinceLoading());
    ApiResponse apiResponse = await AddressRepository.getProvince();
    if (apiResponse.isSuccess!) {
      emit(ProvinceLoaded(apiResponse.data));
    } else {
      emit(ProvinceError(apiResponse.msg!));
    }
  }
}
