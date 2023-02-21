import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/validation_item.dart';
import '../../repositpries/firebase_auth.dart';
import '../../repositpries/user_repositories.dart';
import '../../utils/utils.dart';
import '../../utils/validations.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuthService _authService;
  LoginBloc()
      : _authService = FirebaseAuthService(),
        super(LoginInitial()) {
    on<LoginPressed>(
      (event, emit) async {
        emit(Logining());
        ValidationItem phone = Validations.valPhoneNumber(event.phoneNumber);
        if (phone.error != null) {
          emit(LoginFailed(phoneError: phone.error, errormsg: null));
        } else {
          ApiResponse apiResponse = await UserRepositories.checkUserExist(
              phone: Utils.convertToDB(phone.value.toString()));
          if (apiResponse.isSuccess!) {
            emit(LoginSuccess());
            await _authService.verifyPhone(
                phoneNumber: Utils.convertToFirebase(phone.value.toString()),
                onSendCode: (String verificationId) {
                  emit(LoginSuccess());
                  event.onSuccess(verificationId);
                },
                onFailed: (String msg) {
                  emit(LoginFailed(errormsg: msg, phoneError: null));
                });
          } else {
            emit(LoginFailed(phoneError: null, errormsg: apiResponse.msg));
          }
        }
      },
    );
  }
}
