import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/user.dart' as MyUser;
import '../../repositpries/user_repositories.dart';
import '../../utils/local_Storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthNotAuthenticated()) {
    on<UserLoggedIn>(((event, emit) async {
      // await UserSharedPre.saveUser(event.user);
      if (isClosed) return;
      emit(AuthLoading());
      LocalStorage.saveValue('userID', event.user.userID.toString());
      LocalStorage.saveValue('token', event.user.token);
      if (isClosed) return;
      emit(AuthAuthenticated(user: event.user));
    }));
    on<UserLoggedOut>(((event, emit) async {
      // UserSharedPre.removeUser();
      ApiResponse apiResponse = await UserRepositories.logout(
          userID: event.user.userID, token: event.user.token);
      if (apiResponse.isSuccess!) {
        FirebaseAuth.instance.signOut();
        LocalStorage.clearAll();
        emit(AuthNotAuthenticated());
      } else {
        emit(AuthAuthenticated(user: event.user));
      }
    }));

    on<AppLoaded>((event, emit) async {
      try {
        if (isClosed) return;
        emit(AuthLoading());
        String? userID = LocalStorage.getValue('userID');
        String? token = LocalStorage.getValue('token');
        if (userID != null && token != null) {
          final ApiResponse apiResponse = await UserRepositories.refeshToken(
              token: token, userID: int.parse(userID));
          if (apiResponse.isSuccess!) {
            MyUser.User user = apiResponse.data;
            LocalStorage.saveValue('token', user.token);
            if (isClosed) return;
            emit(AuthAuthenticated(user: user));
          } else {
            LocalStorage.clearAll();
            if (isClosed) return;
            emit(AuthNotAuthenticated());
          }
        } else {
          if (isClosed) return;
          emit(AuthNotAuthenticated());
        }
      } catch (e) {
        if (isClosed) return;
        emit(AuthNotAuthenticated());
      }
    });
    on<UserUpdate>((event, emit) {
      // emit(AuthLoading());
      emit(AuthAuthenticated(user: event.user));
    });
  }
}
