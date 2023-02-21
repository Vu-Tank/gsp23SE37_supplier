import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/bloc/register/register_event.dart';
import 'package:gsp23se37_supplier/src/bloc/register/register_state.dart';

import '../../model/api_response.dart';
import '../../model/validation_item.dart';
import '../../repositpries/firebase_auth.dart';
import '../../repositpries/user_repositories.dart';
import '../../utils/utils.dart';
import '../../utils/validations.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuthService _authService;
  RegisterBloc()
      : _authService = FirebaseAuthService(),
        super(RegisterInitial()) {
    on<RegisterPressed>((event, emit) async {
      emit(Registering());
      ValidationItem phone = Validations.valPhoneNumber(event.phone);
      if (phone.error != null) {
        emit(RegisterFailed(phoneError: phone.error));
      } else {
        ApiResponse apiResponse = await UserRepositories.checkUserExist(
            phone: Utils.convertToDB(phone.value!));
        if (!apiResponse.isSuccess!) {
          try {
            await _authService.verifyPhone(
                phoneNumber: Utils.convertToFirebase(event.phone),
                onFailed: (String msg) {
                  emit(RegisterFailed(errormsg: msg));
                },
                onSendCode: (String verificationId) {
                  emit(RegisterSuccess());
                  event.onSuccess(verificationId);
                });
          } catch (e) {
            emit(RegisterFailed(errormsg: e.toString()));
          }
        } else {
          emit(RegisterFailed(errormsg: apiResponse.msg!));
        }
      }
    });
  }
}
