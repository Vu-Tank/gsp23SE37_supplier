import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/store_withdrawal_request.dart/store_withdrawal_request_cubit.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal_search.dart';
import 'package:gsp23se37_supplier/src/model/withdrawal/withdrawal_status.dart';
import 'package:gsp23se37_supplier/src/utils/app_constants.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:gsp23se37_supplier/src/widget/image_dialog.dart';
import 'package:intl/intl.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/store.dart';
import '../../utils/utils.dart';

class StoreWithdrawalRequestPage extends StatefulWidget {
  const StoreWithdrawalRequestPage({super.key});

  @override
  State<StoreWithdrawalRequestPage> createState() =>
      _StoreWithdrawalRequestPage();
}

class _StoreWithdrawalRequestPage extends State<StoreWithdrawalRequestPage> {
  late WithdrawalSearch search;
  late Store store;
  late User user;
  DateTime? from;
  DateTime? to;
  WithdrawalStatus? status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthState authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      user = authState.user;
      if (user.storeID != -1) {
        ShopState shopState = context.read<ShopBloc>().state;
        if (shopState is ShopCreated) {
          if (shopState.store.store_Status.item_StatusID == 1) {
            store = shopState.store;
            search = WithdrawalSearch(storeID: store.storeID, page: 1);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreWithdrawalRequestCubit()
        ..load(search: search, token: user.token),
      child:
          BlocBuilder<StoreWithdrawalRequestCubit, StoreWithdrawalRequestState>(
        builder: (context, state) {
          return Column(
            children: [
              searchWidget(context: context),
              (state is StoreWithdrawalRequestSuccess)
                  ? Expanded(child: dataWidget(context: context, state: state))
                  : (state is StoreWithdrawalRequestFailed)
                      ? blocLoadFailed(
                          msg: state.msg,
                          reload: () {
                            context
                                .read<StoreWithdrawalRequestCubit>()
                                .load(search: search, token: user.token);
                          },
                        )
                      : const Expanded(
                          child: Center(child: CircularProgressIndicator())),
            ],
          );
        },
      ),
    );
  }

  Widget searchWidget({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!search.isDefault())
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    search = WithdrawalSearch(storeID: search.storeID, page: 1);
                    context
                        .read<StoreWithdrawalRequestCubit>()
                        .load(search: search, token: user.token);
                    from = null;
                    to = null;
                    status = AppConstants.listWithdrawalStatus.first;
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black,
                  )),
            ),
          SizedBox(
            height: 54,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: const BorderSide(width: 5))),
                onPressed: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    locale: const Locale("vi", "VN"),
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2018),
                    lastDate: DateTime.now(),
                  );
                  if (dateTime != null) {
                    setState(() {
                      from = dateTime;
                    });
                  }
                },
                child: Text(
                  (from != null)
                      ? Utils.convertDateTimeToString(from!)
                      : 'Từ ngày',
                  style: AppStyle.textButtom,
                )),
          ),
          const SizedBox(
            width: 8.0,
          ),
          SizedBox(
            height: 54,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        side: const BorderSide(width: 5))),
                onPressed: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    locale: const Locale("vi", "VN"),
                    initialDate: DateTime.now(),
                    firstDate: (from != null) ? from! : DateTime(2018),
                    lastDate: DateTime.now(),
                  );
                  if (dateTime != null) {
                    setState(() {
                      to = dateTime;
                    });
                  }
                },
                child: Text(
                  (to != null)
                      ? Utils.convertDateTimeToString(to!)
                      : 'Đến ngày',
                  style: AppStyle.textButtom,
                )),
          ),
          const SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: 200,
            child: DropdownButtonFormField(
              value: status ?? AppConstants.listWithdrawalStatus.first,
              icon: const Icon(Icons.arrow_downward),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(40)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppStyle.appColor, width: 2),
                    borderRadius: BorderRadius.circular(40)),
              ),
              borderRadius: BorderRadius.circular(20),
              isExpanded: true,
              elevation: 16,
              validator: (value) {
                return null;
              },
              style: AppStyle.h2,
              onChanged: (WithdrawalStatus? value) {
                if (value != null) {
                  status = value;
                }
              },
              items: AppConstants.listWithdrawalStatus
                  .map<DropdownMenuItem<WithdrawalStatus>>(
                      (WithdrawalStatus value) {
                return DropdownMenuItem<WithdrawalStatus>(
                  value: value,
                  child: Text(
                    value.statusName,
                    style: AppStyle.h2,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          IconButton(
              onPressed: () {
                context.read<StoreWithdrawalRequestCubit>().load(
                    search: search.copyWith(
                      statusID: status?.item_StatusID,
                      from: (from != null)
                          ? Utils.convertDateTimeToString(from!)
                          : null,
                      to: (to != null)
                          ? Utils.convertDateTimeToString(to!)
                          : null,
                    ),
                    token: user.token);
                setState(() {
                  search = search.copyWith(
                    statusID: status?.item_StatusID,
                    from: (from != null)
                        ? Utils.convertDateTimeToString(from!)
                        : null,
                    to: (to != null)
                        ? Utils.convertDateTimeToString(to!)
                        : null,
                  );
                  if (status != null && status!.item_StatusID == -1) {
                    search.statusID = null;
                  }
                });
              },
              icon: const Icon(
                Icons.search,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }

  Widget dataWidget(
      {required StoreWithdrawalRequestSuccess state,
      required BuildContext context}) {
    if (state.list.isNotEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
              }),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: constraints.maxWidth),
                      child: DataTable(
                          showCheckboxColumn: false,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          columns: [
                            DataColumn(
                                label: Text(
                              'Mã',
                              style: AppStyle.h2,
                            )),
                            DataColumn(
                                label: Text(
                              'Thời gian',
                              style: AppStyle.h2,
                            )),
                            DataColumn(
                                label: Text(
                              'Ngân hàng',
                              style: AppStyle.h2,
                            )),
                            DataColumn(
                                label: Text(
                              'Số tài khoản',
                              style: AppStyle.h2,
                            )),
                            DataColumn(
                                label: Text(
                              'Tên Chủ thẻ',
                              style: AppStyle.h2,
                            )),
                            DataColumn(
                                label: Text(
                              'Trạng thái',
                              style: AppStyle.h2,
                            )),
                            DataColumn(
                                label: Text(
                              'Số tiền',
                              style: AppStyle.h2,
                            )),
                          ],
                          rows: List.generate(state.list.length, (index) {
                            Withdrawal withdrawal = state.list[index];
                            return DataRow(
                                onSelectChanged: (value) {
                                  if (withdrawal.image != null) {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) => Dialog(
                                    //     child: SizedBox(
                                    //       height: 300,
                                    //       width: 300,
                                    //       child: Image.network(
                                    //         withdrawal.image!.path,
                                    //         fit: BoxFit.cover,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
                                    showDialog(
                                      context: context,
                                      builder: (context) => imageDialog(
                                          context: context,
                                          url: withdrawal.image!.path,
                                          w: 200,
                                          h: 200),
                                    );
                                  }
                                  if (withdrawal
                                          .withdrawal_Status.item_StatusID ==
                                      3) {
                                    MyDialog.showAlertDialog(context,
                                        'Yêu cầu bị huỷ vì: ${withdrawal.reason!}');
                                  }
                                },
                                cells: [
                                  DataCell(Text(
                                    withdrawal.store_WithdrawalID.toString(),
                                    style: AppStyle.h2,
                                  )),
                                  DataCell(Text(
                                    withdrawal.create_Date.split('T')[0],
                                    style: AppStyle.h2,
                                  )),
                                  DataCell(Text(
                                    withdrawal.bankName,
                                    style: AppStyle.h2,
                                  )),
                                  DataCell(Text(
                                    withdrawal.numBankCart,
                                    style: AppStyle.h2,
                                  )),
                                  DataCell(Text(
                                    withdrawal.ownerBankCart,
                                    style: AppStyle.h2,
                                  )),
                                  DataCell(Text(
                                    withdrawal.withdrawal_Status.statusName,
                                    style: AppStyle.h2,
                                  )),
                                  DataCell(Text(
                                    NumberFormat.currency(
                                            locale: 'vi-VN', decimalDigits: 0)
                                        .format(withdrawal.price),
                                    style: AppStyle.h2,
                                  )),
                                ]);
                          })),
                    ),
                    if (state.totalPage > 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed:
                                  (state.currentPage == 1) ? null : () {},
                              icon: const Icon(
                                Icons.arrow_back_outlined,
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              state.currentPage.toString(),
                              style: AppStyle.h2,
                            ),
                          ),
                          IconButton(
                              onPressed: (state.currentPage == state.totalPage)
                                  ? null
                                  : () {},
                              icon: const Icon(
                                Icons.arrow_forward_outlined,
                                // color: Colors.black,
                              )),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    } else {
      return Center(
        child: Text(
          'Không tìm thấy kết quả nào',
          style: AppStyle.h2,
        ),
      );
    }
  }
}
