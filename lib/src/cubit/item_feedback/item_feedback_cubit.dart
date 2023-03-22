import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/api_response.dart';
import 'package:gsp23se37_supplier/src/model/feedback.dart';
import 'package:gsp23se37_supplier/src/repositpries/feeback_repositories.dart';

part 'item_feedback_state.dart';

class ItemFeedbackCubit extends Cubit<ItemFeedbackState> {
  ItemFeedbackCubit() : super(ItemFeedbackInitial());
  loadFeedback(
      {required int itemID, required int page, required String token}) async {
    if (isClosed) return;
    emit(ItemFeedbackLoading());
    ApiResponse apiResponse = await FeedbackRepositories.getItemDetail(
        itemID: itemID, page: page, token: token);
    if (apiResponse.isSuccess!) {
      if (isClosed) return;
      emit(ItemFeedbackLoaded(
          feedbacks: apiResponse.data,
          currentPage: page++,
          totalPage: apiResponse.totalPage!));
    } else {
      if (isClosed) return;
      emit(ItemFeedbackLoadFailed(currentPage: page, msg: apiResponse.msg!));
    }
  }
}
