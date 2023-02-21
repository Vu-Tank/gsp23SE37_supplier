import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/api_response.dart';
import '../../repositpries/system_repositories.dart';

part 'shop_payment_state.dart';

class ShopPaymentCubit extends Cubit<ShopPaymentState> {
  ShopPaymentCubit() : super(ShopPaymentInitial());
  loadPaymentDialog() async {
    ApiResponse apiResponse = await SystemRepositories.getPriceActice();
    if (apiResponse.isSuccess!) {
      emit(ShopPaymentLoaded(apiResponse.data));
    } else {
      emit(ShopPaymentLoadFaild(apiResponse.msg!));
    }
  }
}
