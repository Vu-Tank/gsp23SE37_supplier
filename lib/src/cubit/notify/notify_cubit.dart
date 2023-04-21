import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/notify.dart';
import 'package:gsp23se37_supplier/src/repositpries/user_repositories.dart';

part 'notify_state.dart';

class NotifyCubit extends Cubit<NotifyState> {
  NotifyCubit() : super(NotifyInitial());
  loadNotify(
      {required int userid, required String token, required int page}) async {
    if (isClosed) return;
    emit(Notifyloading());
    ApiResponse apiResponse = await UserRepositories.getNotify(
        userID: userid, token: token, page: page);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(NotifyLoaded(
          list: apiResponse.data,
          currentPage: page,
          totalPage: apiResponse.totalPage!));
    } else {
      if (isClosed) return;
      emit(NotifyFailed(apiResponse.msg!));
    }
  }
}
