import 'dart:ui';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/bloc/all_order/all_order_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/order_ticket/order_ticket_cubit.dart';
import 'package:gsp23se37_supplier/src/model/order/order_search.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/page/order/search_order_widget.dart';
import 'package:gsp23se37_supplier/src/page/order/ship_order_widget.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:intl/intl.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../cubit/order_detail/order_detail_cubit.dart';
import '../../model/store.dart';
import 'order_detail_widget.dart';
import 'recipient_information_wigdet.dart';

class WaitingForTheGoodsPage extends StatefulWidget {
  const WaitingForTheGoodsPage({super.key});

  @override
  State<WaitingForTheGoodsPage> createState() => _WaitingForTheGoodsPageState();
}

class _WaitingForTheGoodsPageState extends State<WaitingForTheGoodsPage> {
  late Store store;
  late User user;
  late OrderSearch _orderSearch;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    AuthState authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      user = authState.user;
      if (user.storeID != -1) {
        ShopState shopState = context.read<ShopBloc>().state;
        if (shopState is ShopCreated) {
          if (shopState.store.store_Status.item_StatusID == 1) {
            store = shopState.store;
            _orderSearch = OrderSearch(
                storeID: store.storeID, shipOrderStatus: 3, page: 1);
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
            create: (context) => AllOrderBloc()
              ..add(AllOrderLoad(orderSearch: _orderSearch, token: user.token)),
          ),
          BlocProvider(
            create: (context) => OrderDetailCubit(),
          )
        ],
        child: Center(
          child: BlocBuilder<AllOrderBloc, AllOrderState>(
            builder: (context, ordersState) {
              context.read<OrderDetailCubit>().reset();
              return Column(
                children: [
                  searchOrderWidget(
                    context: context,
                    searchController: _searchController,
                    orderSearch: _orderSearch,
                    onSearch: (orderSearch) {
                      _orderSearch = orderSearch;
                      // print(_orderSearch.toString());
                      context.read<AllOrderBloc>().add(AllOrderLoad(
                          orderSearch: orderSearch, token: user.token));
                    },
                  ),
                  Expanded(
                    child: (ordersState is AllOrderLoadFailed)
                        ? blocLoadFailed(
                            msg: ordersState.msg,
                            reload: () {
                              context.read<AllOrderBloc>().add(AllOrderLoad(
                                  orderSearch: ordersState.orderSearch,
                                  token: user.token));
                            })
                        : (ordersState is AllOrderLoaded)
                            ? ((ordersState.listOrder.isEmpty)
                                ? ((_orderSearch.orderID != null ||
                                        _orderSearch.userName != null)
                                    ? Center(
                                        child: Text(
                                          'Đơn hàng không tồn tại',
                                          style: AppStyle.h2,
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'Chưa có đơn hàng',
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
                                                  child: DataTable(
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
                                                        'Tổng tiền',
                                                        style: AppStyle.h2,
                                                      )),
                                                      DataColumn(
                                                          label: Text(
                                                        'Người nhận',
                                                        style: AppStyle.h2,
                                                      )),
                                                      DataColumn(
                                                          label: Text(
                                                        'Phương thức',
                                                        style: AppStyle.h2,
                                                      )),
                                                      DataColumn(
                                                          label: Text(
                                                        'Trạng thái',
                                                        style: AppStyle.h2,
                                                      )),
                                                      DataColumn(
                                                          label: Text(
                                                        'Sản phẩm',
                                                        style: AppStyle.h2,
                                                      )),
                                                      DataColumn(
                                                          label: Text(
                                                        'Thao tác',
                                                        style: AppStyle.h2,
                                                      )),
                                                    ],
                                                    rows: [
                                                      ...ordersState.listOrder
                                                          .asMap()
                                                          .entries
                                                          .map((order) {
                                                        return DataRow(cells: [
                                                          DataCell(Text(
                                                            order.value.orderID
                                                                .toString(),
                                                            style: AppStyle.h2,
                                                          )),
                                                          DataCell(Text(
                                                            order.value
                                                                .create_Date
                                                                .split('T')
                                                                .first,
                                                            style: AppStyle.h2,
                                                          )),
                                                          DataCell(Tooltip(
                                                            message:
                                                                'Tiền hàng: ${NumberFormat.currency(locale: "vi-VN", decimalDigits: 0).format(order.value.priceItem)}\nTiền vận chuyển: ${NumberFormat.currency(locale: "vi-VN", decimalDigits: 0).format(order.value.feeShip)}',
                                                            child: Text(
                                                              NumberFormat.currency(
                                                                      locale:
                                                                          "vi-VN",
                                                                      decimalDigits:
                                                                          0)
                                                                  .format(order
                                                                          .value
                                                                          .priceItem +
                                                                      order
                                                                          .value
                                                                          .feeShip),
                                                              style:
                                                                  AppStyle.h2,
                                                            ),
                                                          )),
                                                          DataCell(InkWell(
                                                            child: Text(
                                                              order.value.name,
                                                              style: AppStyle.h2
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .blue),
                                                            ),
                                                            onTap: () async =>
                                                                showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  recipientInformationWidget(
                                                                      context:
                                                                          context,
                                                                      name: order
                                                                          .value
                                                                          .name,
                                                                      phone: order
                                                                          .value
                                                                          .tel,
                                                                      address:
                                                                          '${order.value.address}, ${order.value.ward},\n${order.value.district}, ${order.value.province}'),
                                                            ),
                                                          )),
                                                          DataCell(Text(
                                                            order.value
                                                                .paymentMethod,
                                                            style: AppStyle.h2,
                                                          )),
                                                          DataCell(
                                                              Tooltip(
                                                                message: order
                                                                    .value
                                                                    .orderShip
                                                                    .status,
                                                                child: SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    order
                                                                        .value
                                                                        .orderShip
                                                                        .status,
                                                                    style: AppStyle
                                                                        .h2
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.blue),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: () async =>
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder: (context) => shipOrderWidget(
                                                                        context:
                                                                            context,
                                                                        orderID: order
                                                                            .value
                                                                            .orderID,
                                                                        token: user
                                                                            .token),
                                                                  )),
                                                          DataCell(InkWell(
                                                            child: Text(
                                                              'Xem chi tiết',
                                                              style: AppStyle.h2
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .blue),
                                                            ),
                                                            onTap: () async {
                                                              context
                                                                  .read<
                                                                      OrderDetailCubit>()
                                                                  .loadOrderDetail(
                                                                      order: order
                                                                          .value,
                                                                      token: user
                                                                          .token);
                                                            },
                                                          )),
                                                          DataCell(BlocProvider(
                                                            create: (context) =>
                                                                OrderTicketCubit(),
                                                            child: BlocConsumer<
                                                                OrderTicketCubit,
                                                                OrderTicketState>(
                                                              listener:
                                                                  (context,
                                                                      state) {
                                                                if (state
                                                                    is OrderTicketFailed) {
                                                                  MyDialog.showSnackBar(
                                                                      context,
                                                                      state
                                                                          .msg);
                                                                }
                                                              },
                                                              builder: (context,
                                                                  orderTicketState) {
                                                                return InkWell(
                                                                  child: (orderTicketState
                                                                          is OrderTicketLoading)
                                                                      ? const CircularProgressIndicator()
                                                                      : Text(
                                                                          'In nhãn',
                                                                          style: AppStyle
                                                                              .h2
                                                                              .copyWith(color: Colors.blue),
                                                                        ),
                                                                  onTap:
                                                                      () async {
                                                                    // await launchUrl(Uri.parse(
                                                                    //     '${AppUrl.getTicket}?orderID=${order.value.orderID}'));
                                                                    context
                                                                        .read<
                                                                            OrderTicketCubit>()
                                                                        .getTicker(
                                                                            orderID:
                                                                                order.value.orderID,
                                                                            token: user.token,
                                                                            onSuccess: (String data) {
                                                                              AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,$data")
                                                                                ..setAttribute("download", "esmp_ship_${order.value.orderID}.pdf")
                                                                                ..click();
                                                                            });
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          )),
                                                        ]);
                                                      })
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                        onPressed: (ordersState
                                                                    .currentPage ==
                                                                1)
                                                            ? null
                                                            : () => context
                                                                .read<
                                                                    AllOrderBloc>()
                                                                .add(AllOrderLoad(
                                                                    orderSearch:
                                                                        _orderSearch.copyWith(
                                                                            page: ordersState.currentPage -
                                                                                1),
                                                                    token: user
                                                                        .token)),
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
                                                        ordersState.currentPage
                                                            .toString(),
                                                        style: AppStyle.h2,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: (ordersState
                                                                    .currentPage ==
                                                                ordersState
                                                                    .totalPage)
                                                            ? null
                                                            : () => context
                                                                .read<
                                                                    AllOrderBloc>()
                                                                .add(AllOrderLoad(
                                                                    orderSearch:
                                                                        _orderSearch.copyWith(
                                                                            page: ordersState.currentPage +
                                                                                1),
                                                                    token: user
                                                                        .token)),
                                                        icon: const Icon(
                                                          Icons
                                                              .arrow_forward_outlined,
                                                          // color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                                BlocBuilder<OrderDetailCubit,
                                                    OrderDetailState>(
                                                  builder: (context,
                                                      orderDetailState) {
                                                    if (orderDetailState
                                                        is OrderDetailInitial) {
                                                      return Container();
                                                    } else if (orderDetailState
                                                        is OrderDetailLoaded) {
                                                      return orderDetailWidget(
                                                          context: context,
                                                          order:
                                                              orderDetailState
                                                                  .order);
                                                    } else {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ))
                            : const Center(child: CircularProgressIndicator()),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
