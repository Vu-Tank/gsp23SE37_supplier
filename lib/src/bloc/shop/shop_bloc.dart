import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../model/store.dart';
import '../../repositpries/store_repositories.dart';
import '../../repositpries/system_repositories.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    on<ShopLogin>((event, emit) async {
      emit(ShopLoading());
      ApiResponse apiResponse = await StoreRepositories.storeLogin(
          userId: event.userID, token: event.token);
      if (apiResponse.isSuccess!) {
        Store store = apiResponse.data;
        if (store.store_Status.item_StatusID == 1) {
          emit(ShopCreated(apiResponse.data, 0));
        } else {
          apiResponse = await SystemRepositories.getPriceActice();
          if (apiResponse.isSuccess!) {
            emit(ShopCreated(store, apiResponse.data));
          } else {
            emit(ShopLoginFailed(apiResponse.msg!));
          }
        }
      } else {
        emit(ShopLoginFailed(apiResponse.msg!));
      }
    });
    on<ShopPayment>((event, emit) async {
      emit(ShopLoading());
      ApiResponse apiResponse = await StoreRepositories.storePayment(
          storeID: event.storeID, token: event.token);
      if (apiResponse.isSuccess!) {
        try {
          // await launchUrl(Uri.parse(apiResponse.data),
          //     mode: LaunchMode.platformDefault);
          event.onSuccess(apiResponse.data);
        } catch (e) {
          emit(ShopPaymentFailed(e.toString(), event.storeID));
        }
      } else {
        emit(ShopPaymentFailed(apiResponse.msg!, event.storeID));
      }
    });
    on<ShopUpdate>((event, emit) {
      emit(ShopCreated(event.store, event.store.actice_Amount!));
    });
  }
}
