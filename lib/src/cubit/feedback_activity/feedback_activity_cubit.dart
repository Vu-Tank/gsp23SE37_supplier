import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/repositpries/order_repositories.dart';

part 'feedback_activity_state.dart';

class FeedbackActivityCubit extends Cubit<FeedbackActivityState> {
  FeedbackActivityCubit() : super(FeedbackActivityInitial());
  hidenFeedback({required String token, required int orderDetailID}) async {
    if (isClosed) return;
    emit(FeedbackActivityLoading());
    ApiResponse apiResponse = await OrderRepositories.hiddenFeedback(
        orderDetailID: orderDetailID, token: token);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(FeedbackActivitySuccess());
    } else {
      if (isClosed) return;
      emit(FeedbackActivityFailed(apiResponse.msg!));
    }
  }

  unHidenFeedback({required String token, required int orderDetailID}) async {
    if (isClosed) return;
    emit(FeedbackActivityLoading());
    ApiResponse apiResponse = await OrderRepositories.unHiddenFeedback(
        orderDetailID: orderDetailID, token: token);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(FeedbackActivitySuccess());
    } else {
      if (isClosed) return;
      emit(FeedbackActivityFailed(apiResponse.msg!));
    }
  }
}
