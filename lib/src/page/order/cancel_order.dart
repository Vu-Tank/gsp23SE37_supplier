import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/cancel_order/cancel_order_cubit.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

Widget cancelOrderDialog(
    {required BuildContext context,
    required int orderID,
    required String token}) {
  final formKey = GlobalKey<FormState>();
  TextEditingController reason = TextEditingController();
  return Dialog(
    child: BlocProvider(
      create: (context) => CancelOrderCubit(),
      child: BlocConsumer<CancelOrderCubit, CancelOrderState>(
        listener: (context, state) {
          if (state is CancelOrderSuccess) {
            context.pop(true);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Huỷ đơn hàng $orderID',
                      style: AppStyle.h2,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: reason,
                      textAlign: TextAlign.left,
                      style: AppStyle.h2,
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập lý do huỷ đơn hàng';
                        } else if (value.length < 10) {
                          return 'Lý do huỷ đơn hàng phải lơn hơn hoặc bằng 10 ký tự';
                        }
                        return null;
                      },
                      maxLength: 1000,
                      decoration: InputDecoration(
                        errorText: null,
                        errorStyle: AppStyle.errorStyle.copyWith(fontSize: 15),
                        hintText: 'Lý do huỷ đơn hàng',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    if (state is CancelOrderFailed)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          state.msg,
                          style: AppStyle.h2,
                        ),
                      ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop(false);
                          },
                          child: Text(
                            'Thoát',
                            style: AppStyle.buttom.copyWith(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<CancelOrderCubit>().cancelOrder(
                                  reason: reason.text.trim(),
                                  orderID: orderID,
                                  token: token);
                            }
                          },
                          child: (state is CancelOrderLoading)
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Xác nhận',
                                  style: AppStyle.buttom
                                      .copyWith(color: Colors.blue),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
