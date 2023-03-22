import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/cash_flow/cash_flow_cubit.dart';
import 'package:gsp23se37_supplier/src/model/cash_flow_search.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/utils.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:intl/intl.dart';

import '../../model/cash_flow.dart';

class CashFlowDialog extends StatefulWidget {
  const CashFlowDialog({super.key, required this.storeID, required this.token});
  final int storeID;
  final String token;
  @override
  State<CashFlowDialog> createState() => _CashFlowDialogState();
}

class _CashFlowDialogState extends State<CashFlowDialog> {
  late CashFlowSearch search;
  DateTime? from;
  DateTime? to;
  @override
  void initState() {
    super.initState();
    search = CashFlowSearch(storeID: widget.storeID, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocProvider(
        create: (context) =>
            CashFlowCubit()..loadCashFlow(token: widget.token, search: search),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<CashFlowCubit, CashFlowState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
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
                        TextButton(
                            onPressed: () async {
                              DateTime? dateTime = await showDatePicker(
                                context: context,
                                locale: const Locale("vi", "VN"),
                                initialDate: DateTime.now(),
                                firstDate:
                                    (from != null) ? from! : DateTime(2018),
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
                        IconButton(
                            onPressed: () {
                              context.read<CashFlowCubit>().loadCashFlow(
                                  token: widget.token,
                                  search: search.copyWith(
                                    from: (from != null)
                                        ? Utils.convertDateTimeToString(from!)
                                        : null,
                                    page: 1,
                                    to: (to != null)
                                        ? Utils.convertDateTimeToString(to!)
                                        : null,
                                  ));
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    (state is CashFlowLoaded)
                        ? (Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Dòng tiền",
                                style: AppStyle.h2,
                              ),
                              DataTable(
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Mã',
                                      style: AppStyle.h2,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Mã đơn hàng',
                                      style: AppStyle.h2,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Thời gian',
                                      style: AppStyle.h2,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Thành tiền',
                                      style: AppStyle.h2,
                                    )),
                                  ],
                                  rows:
                                      List.generate(state.list.length, (index) {
                                    CashFlow cashFlow = state.list[index];
                                    return DataRow(cells: [
                                      DataCell(Text(
                                        cashFlow.orderStore_TransactionID
                                            .toString(),
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        cashFlow.orderID.toString(),
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        cashFlow.create_Date.split('T')[0],
                                        style: AppStyle.h2,
                                      )),
                                      DataCell(Text(
                                        NumberFormat.currency(
                                                locale: 'vi-VN',
                                                decimalDigits: 0)
                                            .format(cashFlow.price),
                                        style: AppStyle.h2,
                                      )),
                                    ]);
                                  })),
                              (state.totalPage != 1)
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: (state.curentPage == 1)
                                                ? null
                                                : () => context
                                                    .read<CashFlowCubit>()
                                                    .loadCashFlow(
                                                        token: widget.token,
                                                        search: search.copyWith(
                                                            page: search.page -
                                                                1)),
                                            icon: const Icon(
                                              Icons.arrow_back_outlined,
                                              // color: Colors.black,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Text(
                                            state.curentPage.toString(),
                                            style: AppStyle.h2,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: (state.curentPage ==
                                                    state.totalPage)
                                                ? null
                                                : () => context
                                                    .read<CashFlowCubit>()
                                                    .loadCashFlow(
                                                        token: widget.token,
                                                        search: search.copyWith(
                                                            page: search.page +
                                                                1)),
                                            icon: const Icon(
                                              Icons.arrow_forward_outlined,
                                              // color: Colors.black,
                                            )),
                                      ],
                                    )
                                  : Text(
                                      'Có ${state.list.length} kết quá',
                                      style: AppStyle.h2,
                                    ),
                            ],
                          ))
                        : (state is CashFlowLoadFailed)
                            ? (blocLoadFailed(
                                msg: state.msg,
                                reload: () {
                                  context.read<CashFlowCubit>().loadCashFlow(
                                      token: widget.token, search: search);
                                },
                              ))
                            : (const CircularProgressIndicator())
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
