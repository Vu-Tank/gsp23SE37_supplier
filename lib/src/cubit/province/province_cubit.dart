import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/address/province.dart';
import '../../model/api_response.dart';
import '../../repositpries/address_repositories.dart';

part 'province_state.dart';

class ProvinceCubit extends Cubit<ProvinceState> {
  ProvinceCubit() : super(ProvinceInitial());
  loadProvince({String? proviceName}) async {
    if (isClosed) return;
    emit(ProvinceLoading());
    ApiResponse apiResponse = await AddressRepository.getProvince();
    if (apiResponse.isSuccess!) {
      List<Province> list = apiResponse.data;
      Province selected = list.first;
      if (proviceName != null) {
        for (var element in list) {
          if (element.value == proviceName) {
            selected = element;
            break;
          }
        }
      }
      if (isClosed) return;
      emit(ProvinceLoaded(provinces: list, province: selected));
    } else {
      if (isClosed) return;
      emit(ProvinceError(apiResponse.msg!));
    }
  }

  selectedProvince({required List<Province> list, required Province province}) {
    if (isClosed) return;
    emit(ProvinceLoading());
    if (isClosed) return;
    emit(ProvinceLoaded(provinces: list, province: province));
  }
}
