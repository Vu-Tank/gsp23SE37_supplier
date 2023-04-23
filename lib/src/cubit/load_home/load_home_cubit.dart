import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/store.dart';
import '../../repositpries/store_repositories.dart';

part 'load_home_state.dart';

class LoadHomeCubit extends Cubit<LoadHomeState> {
  LoadHomeCubit() : super(LoadHomeInitial());
  load({required int userId, required String token}) async {
    if (isClosed) return;
    emit(Loading());
    ApiResponse apiResponse =
        await StoreRepositories.storeLogin(userId: userId, token: token);
    if (apiResponse.isSuccess!) {
      Store store = apiResponse.data;
      emit(LoadHomeSuccess(store));
    } else {
      emit(Failed(apiResponse.msg!));
    }
  }
}
