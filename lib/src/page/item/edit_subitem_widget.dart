import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/update_subitem/update_subitem_cubit.dart';
import 'package:gsp23se37_supplier/src/model/item/sub_item.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

import '../../utils/validations.dart';

Widget editSubItemWidget(
    {required SubItem subItem, required String token, required String type}) {
  TextEditingController value = TextEditingController(
      text: (type == 'amount')
          ? subItem.amount.toString()
          : subItem.price.toString());
  final formKey = GlobalKey<FormState>();
  return Dialog(
    child: StatefulBuilder(
      builder: (context, setState) {
        return BlocProvider(
          create: (context) => UpdateSubitemCubit(),
          child: BlocConsumer<UpdateSubitemCubit, UpdateSubitemState>(
            listener: (context, state) {
              if (state is UpdateSubitemSuccess) {
                if (type == 'price') {
                  context.pop(subItem.copyWith(
                      price: double.parse(value.text
                          .replaceAll('VNĐ', '')
                          .replaceAll('.', '')
                          .trim())));
                }
                if (type == 'amount') {
                  context.pop(
                      subItem.copyWith(amount: int.parse(value.text.trim())));
                }
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (type == 'amount') ? 'Chỉnh số lượng' : 'Chỉnh giá',
                        style: AppStyle.h2,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          controller: value,
                          textAlign: TextAlign.left,
                          style: AppStyle.h2,
                          inputFormatters: [
                            if (type == 'price')
                              CurrencyTextInputFormatter(
                                locale: 'vi_VN',
                                decimalDigits: 0,
                                symbol: 'VNĐ',
                              )
                          ],
                          validator: (value) {
                            if (type == 'amount') {
                              return Validations.valAmount(value);
                            } else if (type == 'price') {
                              return Validations.valPrice(value);
                            }
                            return null;
                          },
                          maxLength: 100,
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            errorStyle:
                                AppStyle.errorStyle.copyWith(fontSize: 15),
                            label: Text(
                              (type == 'amount') ? 'Số lượng' : 'Giá',
                              style: AppStyle.h2,
                            ),
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
                      SizedBox(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text(
                                  'Thoát',
                                  style:
                                      AppStyle.h2.copyWith(color: Colors.blue),
                                )),
                            TextButton(
                                onPressed: (state is UpdateSubItemLoading)
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          switch (type) {
                                            case 'amount':
                                              context
                                                  .read<UpdateSubitemCubit>()
                                                  .updateSubitem(
                                                      token: token,
                                                      subItem: subItem.copyWith(
                                                          amount: int.parse(
                                                              value.text
                                                                  .trim())));
                                              return;
                                            case 'price':
                                              context
                                                  .read<UpdateSubitemCubit>()
                                                  .updateSubitem(
                                                      token: token,
                                                      subItem: subItem.copyWith(
                                                          price: double.parse(
                                                              value.text
                                                                  .replaceAll(
                                                                      'VNĐ', '')
                                                                  .replaceAll(
                                                                      '.', '')
                                                                  .trim())));
                                              return;
                                            default:
                                              return;
                                          }
                                        }
                                      },
                                child: (state is UpdateSubItemLoading)
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        'Lưu',
                                        style: AppStyle.h2
                                            .copyWith(color: Colors.blue),
                                      )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ),
  );
}
