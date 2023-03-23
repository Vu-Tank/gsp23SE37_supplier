import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/service_cancel/service_cancel_cubit.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

Widget cancelServiceDialog(
    {required BuildContext context,
    required int serviceId,
    required int type,
    required String token}) {
  final formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();
  return Dialog(
    child: BlocProvider(
      create: (context) => ServiceCancelCubit(),
      child: BlocConsumer<ServiceCancelCubit, ServiceCancelState>(
        listener: (context, state) {
          context.pop(true);
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  'Từ chối ${(type == 1) ? 'Đổi' : 'Trả'} hàng',
                  style: AppStyle.h2,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  width: 600,
                  child: TextFormField(
                    controller: textEditingController,
                    textAlign: TextAlign.left,
                    style: AppStyle.h2,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nhập lý do đổi trả';
                      }
                      return null;
                    },
                    maxLength: 1000,
                    decoration: InputDecoration(
                      errorText: null,
                      errorStyle: AppStyle.errorStyle.copyWith(fontSize: 15),
                      hintText: 'Lý do',
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                if (state is ServiceCancelFailed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      state.msg,
                      style: AppStyle.errorStyle,
                    ),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          'Thoát',
                          style: AppStyle.textButtom,
                        )),
                    TextButton(
                        onPressed: (state is ServiceCanceling)
                            ? null
                            : () {
                                context
                                    .read<ServiceCancelCubit>()
                                    .cancelService(
                                        serviceID: serviceId,
                                        token: token,
                                        reason:
                                            textEditingController.text.trim());
                              },
                        child: (state is ServiceCanceling)
                            ? const CircularProgressIndicator()
                            : Text(
                                'Xác nhận',
                                style: AppStyle.textButtom,
                              )),
                  ],
                )
              ]),
            ),
          );
        },
      ),
    ),
  );
}
