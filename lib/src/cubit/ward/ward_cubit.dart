import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/address/ward.dart';
import '../../model/api_response.dart';
import '../../repositpries/address_repositories.dart';

part 'ward_state.dart';

class WardCubit extends Cubit<WardState> {
  WardCubit() : super(WardInitial());
  loadWard({required String districtId, String? wardName}) async {
    if (isClosed) return;
    emit(WardLoading());
    ApiResponse apiResponse = await AddressRepository.getWard(districtId);
    if (apiResponse.isSuccess!) {
      List<Ward> list = apiResponse.data;
      Ward ward = list.first;
      if (wardName != null && wardName.isNotEmpty) {
        for (var element in list) {
          if (element.value == wardName) {
            ward = element;
            break;
          }
        }
      }
      if (isClosed) return;
      emit(WardLoaded(wards: list, ward: ward));
    } else {
      if (isClosed) return;
      emit(WardError(apiResponse.msg!));
    }
  }

  selectedWard({required List<Ward> list, required Ward ward}) {
    if (isClosed) return;
    emit(WardLoading());
    if (isClosed) return;
    emit(WardLoaded(wards: list, ward: ward));
  }
}
