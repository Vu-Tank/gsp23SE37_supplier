import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/service_repositories.dart';

part 'service_cancel_state.dart';

class ServiceCancelCubit extends Cubit<ServiceCancelState> {
  ServiceCancelCubit() : super(ServiceCancelInitial());
  cancelService(
      {required int serviceID,
      required String token,
      required String reason}) async {
    if (isClosed) return;
    emit(ServiceCanceling());
    ApiResponse apiResponse = await ServiceRepositorie.cancelService(
        token: token, reason: reason, serviceID: serviceID);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(ServiceCancelSuccess());
    } else {
      emit(ServiceCancelFailed(apiResponse.msg!));
    }
  }
}
