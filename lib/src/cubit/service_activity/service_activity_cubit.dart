import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/service_repositories.dart';

part 'service_activity_state.dart';

class ServiceActivityCubit extends Cubit<ServiceActivityState> {
  ServiceActivityCubit() : super(ServiceActivityInitial());
  accept({required int serviceID, required String token}) async {
    if (isClosed) return;
    emit(ServiceActiviting());
    ApiResponse apiResponse = await ServiceRepositorie.acceptService(
        token: token, serviceID: serviceID);
    if (isClosed) return;
    if (apiResponse.isSuccess!) {
      emit(ServiceActivitySuccess());
    } else {
      emit(ServiceActivityFailed(apiResponse.msg!));
    }
  }
}
