import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/service_buy/service_buy_cubit.dart';
import 'package:gsp23se37_supplier/src/model/service/service_search.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/service/service.dart';
import '../../model/store.dart';
import '../order/recipient_information_wigdet.dart';

class AllServicePage extends StatefulWidget {
  const AllServicePage({super.key, required this.search});
  final ServiceSearch search;
  @override
  State<AllServicePage> createState() => _AllServicePageState();
}

class _AllServicePageState extends State<AllServicePage> {
  late ServiceSearch search;
  late Store store;
  late User user;
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
            search = widget.search;
          } else {
            GoRouter.of(context).pushReplacementNamed('/');
          }
        } else {
          GoRouter.of(context).pushReplacementNamed('/');
        }
      } else {
        GoRouter.of(context).pushReplacementNamed('/');
      }
    } else {
      GoRouter.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ServiceBuyCubit()
              ..loadService(token: user.token, search: search),
          ),
        ],
        child: BlocBuilder<ServiceBuyCubit, ServiceBuyState>(
          builder: (context, serviceBuyState) {
            return Column(
              children: [
                //search
                Container(),
                //date
                Expanded(
                  child: (serviceBuyState is ServiceBuyLoadFailed)
                      ? blocLoadFailed(
                          msg: serviceBuyState.msg,
                          reload: () {
                            context
                                .read<ServiceBuyCubit>()
                                .loadService(token: user.token, search: search);
                          },
                        )
                      : (serviceBuyState is ServiceBuyLoadSuccess)
                          ? ((serviceBuyState.list.isEmpty)
                              ? ((search.isDefault())
                                  ? Center(
                                      child: Text(
                                        'Không có yêu cầu',
                                        style: AppStyle.h2,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Không có yêu cầu',
                                        style: AppStyle.h2,
                                      ),
                                    ))
                              : Container(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LayoutBuilder(builder:
                                        (BuildContext context,
                                            BoxConstraints constraints) {
                                      return ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
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
                                                      minWidth:
                                                          constraints.maxWidth),
                                                  child: serviceView(
                                                      context: context,
                                                      list: serviceBuyState
                                                          .list)),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: (serviceBuyState
                                                                  .currentPage ==
                                                              1)
                                                          ? null
                                                          : () {},
                                                      icon: const Icon(
                                                        Icons
                                                            .arrow_back_outlined,
                                                        // color: Colors.black,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0),
                                                    child: Text(
                                                      serviceBuyState
                                                          .currentPage
                                                          .toString(),
                                                      style: AppStyle.h2,
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: (serviceBuyState
                                                                  .currentPage ==
                                                              serviceBuyState
                                                                  .totalPage)
                                                          ? null
                                                          : () {},
                                                      icon: const Icon(
                                                        Icons
                                                            .arrow_forward_outlined,
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
                                ))
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                ),
              ],
            );
          },
        ));
  }

  Widget serviceView(
      {required BuildContext context, required List<ServiceBuy> list}) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Mã',
            style: AppStyle.h2,
          ),
        ),
        DataColumn(
          label: Text(
            'Ngày đặt',
            style: AppStyle.h2,
          ),
        ),
        DataColumn(
            label: Text(
          'Người nhận',
          style: AppStyle.h2,
        )),
        DataColumn(
            label: Text(
          'Thao tác',
          style: AppStyle.h2,
        )),
      ],
      rows: [
        ...list.asMap().entries.map((serviceBuy) {
          return DataRow(cells: [
            DataCell(Text(
              serviceBuy.value.orderID.toString(),
              style: AppStyle.h2,
            )),
            DataCell(Text(
              serviceBuy.value.create_Date.split('T').first,
              style: AppStyle.h2,
            )),
            DataCell(InkWell(
              child: Text(
                serviceBuy.value.user_Name,
                style: AppStyle.h2.copyWith(color: Colors.blue),
              ),
              onTap: () async => showDialog(
                context: context,
                builder: (context) => recipientInformationWidget(
                    context: context,
                    name: serviceBuy.value.user_Name,
                    phone: serviceBuy.value.user_Tel,
                    address:
                        '${serviceBuy.value.user_Address}, ${serviceBuy.value.user_Ward},\n${serviceBuy.value.user_District}, ${serviceBuy.value.user_Province}'),
              ),
            )),
            DataCell(Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: const Tooltip(
                    message: 'Xem chi tiết đơn hàng',
                    child: Icon(
                      Icons.visibility_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () async {
                    // context.read<OrderDetailCubit>().loadOrderDetail(
                    //     order: order
                    //         .value,
                    //     token: user
                    //         .token);
                  },
                ),
              ],
            )),
          ]);
        })
      ],
    );
  }
}
