import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/data_exchange/data_exchange_cubit.dart';
import 'package:gsp23se37_supplier/src/model/data_exchange/data_exchange.dart';
import 'package:gsp23se37_supplier/src/model/data_exchange/data_exchange_search.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:gsp23se37_supplier/src/widget/image_dialog.dart';
import 'package:intl/intl.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/store.dart';
import '../../model/user.dart';
import '../../utils/app_style.dart';

class DataExchangePage extends StatefulWidget {
  const DataExchangePage({super.key});

  @override
  State<DataExchangePage> createState() => _DataExchangePageState();
}

class _DataExchangePageState extends State<DataExchangePage> {
  late Store store;
  late User user;
  late DataExchangeSearch search;
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
          if (shopState.store.store_Status.item_StatusID == 1 ||
              shopState.store.store_Status.item_StatusID == 4) {
            store = shopState.store;
            search = DataExchangeSearch(storeID: store.storeID, page: 1);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DataExchangeCubit()..load(search: search, token: user.token),
      child: BlocBuilder<DataExchangeCubit, DataExchangeState>(
        builder: (context, state) {
          return Column(children: [
            //search
            Container(),
            //data
            Expanded(
              child: (state is DataExchangeSuccess)
                  ? (state.list.isEmpty)
                      ? Center(
                          child: Text(
                            'Danh sách đối soát đang trống',
                            style: AppStyle.h2,
                          ),
                        )
                      : Container(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch,
                                }),
                                child: SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minWidth: constraints.maxWidth),
                                          child: dataExchangeView(
                                              context: context, state: state)),
                                      if (state.totalPage != 1)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed:
                                                    (state.currentPage == 1)
                                                        ? null
                                                        : () {
                                                            context.read<DataExchangeCubit>().load(
                                                                search: search
                                                                    .copyWith(
                                                                        page: state.currentPage -
                                                                            1),
                                                                token:
                                                                    user.token);
                                                          },
                                                icon: const Icon(
                                                  Icons.arrow_back_outlined,
                                                  // color: Colors.black,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Text(
                                                state.currentPage.toString(),
                                                style: AppStyle.h2,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed:
                                                    (state.currentPage ==
                                                            state.totalPage)
                                                        ? null
                                                        : () {
                                                            context.read<DataExchangeCubit>().load(
                                                                search: search
                                                                    .copyWith(
                                                                        page: state.currentPage +
                                                                            1),
                                                                token:
                                                                    user.token);
                                                          },
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
                        )
                  : (state is DataExchangeFailed)
                      ? blocLoadFailed(
                          msg: state.msg,
                          reload: () {
                            context
                                .read<DataExchangeCubit>()
                                .load(search: search, token: user.token);
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
            ),
          ]);
        },
      ),
    );
  }

  Widget dataExchangeView(
      {required BuildContext context, required DataExchangeSuccess state}) {
    List<DataExchange> list = state.list;
    return DataTable(
        showCheckboxColumn: false,
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
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
          DataColumn(
              label: Text(
            'Trạng thái',
            style: AppStyle.h2,
          )),
        ],
        rows: List.generate(list.length, (index) {
          DataExchange dataExchange = list[index];
          return DataRow(
              onSelectChanged: (value) {
                if (dataExchange.image != null) {
                  showDialog(
                      context: context,
                      builder: (context) => imageDialog(
                          context: context,
                          url: dataExchange.image!.path,
                          w: 300,
                          h: 300));
                }
              },
              color: (state.selected != null &&
                      dataExchange.exchangeStoreID ==
                          state.selected!.exchangeStoreID)
                  ? const MaterialStatePropertyAll(
                      Color.fromARGB(255, 189, 220, 246))
                  : null,
              cells: [
                DataCell(Text(
                  dataExchange.exchangeStoreID.toString(),
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  dataExchange.orderID.toString(),
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  dataExchange.create_date.split('T')[0],
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  NumberFormat.currency(locale: 'vi-VN', decimalDigits: 0)
                      .format(dataExchange.exchangePrice),
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  dataExchange.exchangeStatus.statusName,
                  style: AppStyle.h2,
                )),
              ]);
        }));
  }
}
