import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/store_withdrawal/store_withdrawal_cubit.dart';
import 'package:gsp23se37_supplier/src/utils/app_constants.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/validations.dart';
import 'package:intl/intl.dart';

import '../../model/store.dart';
import '../../model/user.dart';

Widget storeWithdraWalDialog(
    {required BuildContext context, required User user, required Store store}) {
  return Dialog(
    child: StatefulBuilder(builder: (context, setStateDialo) {
      String bankSelecte = AppConstants.banks.first;
      TextEditingController bankNumber = TextEditingController();
      TextEditingController bankOwner = TextEditingController();
      TextEditingController price = TextEditingController();
      final formKey = GlobalKey<FormState>();
      return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => StoreWithdrawalCubit(),
            )
          ],
          child: BlocConsumer<StoreWithdrawalCubit, StoreWithdrawalState>(
            listener: (context, storeWithdrawalState) {
              if (storeWithdrawalState is StoreWithdrawalSuccess) {
                context.pop();
              }
            },
            builder: (context, storeWithdrawalState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tài khoản: ${NumberFormat.currency(
                            locale: 'vi_VN',
                            decimalDigits: 0,
                            symbol: 'VNĐ',
                          ).format(store.asset)}',
                          style: AppStyle.h2,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        DropdownButtonFormField(
                          value: bankSelecte,
                          icon: const Icon(Icons.arrow_downward),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppStyle.appColor, width: 2),
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          elevation: 18,
                          style: AppStyle.h2,
                          onChanged: (String? value) {
                            if (value != null) {
                              bankSelecte = value;
                            }
                          },
                          items: AppConstants.banks
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  Text(
                                    value,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: AppStyle.h2,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: bankNumber,
                          textAlign: TextAlign.left,
                          style: AppStyle.h2,
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: Validations.valBankNumber,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.payment),
                            label: Text(
                              'Số tài khoản',
                              style: AppStyle.h2,
                            ),
                            errorStyle:
                                AppStyle.errorStyle.copyWith(fontSize: 15),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: bankOwner,
                          textAlign: TextAlign.left,
                          style: AppStyle.h2,
                          maxLines: 1,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100),
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z ]")),
                          ],
                          textCapitalization: TextCapitalization.characters,
                          validator: Validations.valAccountName,
                          decoration: InputDecoration(
                            prefixIcon:
                                const Icon(Icons.account_balance_outlined),
                            label: Text(
                              'Chủ tài khoản',
                              style: AppStyle.h2,
                            ),
                            errorStyle:
                                AppStyle.errorStyle.copyWith(fontSize: 15),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: price,
                          textAlign: TextAlign.left,
                          style: AppStyle.h2,
                          maxLines: 1,
                          validator: (value) => Validations.valPriceWithdrawal(
                              value, store.asset),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                            CurrencyTextInputFormatter(
                              locale: 'vi-VN',
                              decimalDigits: 0,
                              symbol: 'VNĐ',
                            )
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.attach_money_rounded),
                            label: Text(
                              'Số tiền muốn rút',
                              style: AppStyle.h2,
                            ),
                            errorStyle:
                                AppStyle.errorStyle.copyWith(fontSize: 15),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        if (storeWithdrawalState is StoreWithdrawalLoadFailed)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              storeWithdrawalState.msg,
                              style: AppStyle.errorStyle,
                            ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text(
                                    'Thoát',
                                    style: AppStyle.textButtom,
                                  )),
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<StoreWithdrawalCubit>()
                                          .storeWithdrawal(
                                              token: user.token,
                                              storeID: store.storeID,
                                              price: double.parse(price.text
                                                  .replaceAll('VNĐ', '')
                                                  .replaceAll('.', '')
                                                  .trim()),
                                              numBankCart:
                                                  bankNumber.text.trim(),
                                              ownerBankCart:
                                                  bankOwner.text.toString(),
                                              bankName: bankSelecte);
                                    }
                                  },
                                  child: (storeWithdrawalState
                                          is StoreWithdrawalLoading)
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          'Rút',
                                          style: AppStyle.textButtom,
                                        )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ));
    }),
  );
}
