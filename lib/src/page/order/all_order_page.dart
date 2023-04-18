import 'dart:ui';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/bloc/all_order/all_order_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/order_packing_video/order_packing_video_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/order_ticket/order_ticket_cubit.dart';
import 'package:gsp23se37_supplier/src/model/order/order_search.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/page/order/cancel_order.dart';
import 'package:gsp23se37_supplier/src/page/order/search_order_widget.dart';
import 'package:gsp23se37_supplier/src/page/order/ship_order_widget.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/order/order.dart';
import '../../model/store.dart';
import '../video_dilog.dart';
import 'order_detail_widget.dart';
import 'recipient_information_wigdet.dart';

class AllOrderPage extends StatefulWidget {
  const AllOrderPage(
      {super.key, required this.orderSearch, required this.sidebarXController});
  final OrderSearch orderSearch;
  final SidebarXController sidebarXController;
  @override
  State<AllOrderPage> createState() => _AllOrderPageState();
}

class _AllOrderPageState extends State<AllOrderPage> {
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
          if (shopState.store.store_Status.item_StatusID == 1 ||
              shopState.store.store_Status.item_StatusID == 4) {
            store = shopState.store;
            _orderSearch = widget.orderSearch;
          }
        }
      }
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
        ],
        child: Center(
          child: BlocBuilder<AllOrderBloc, AllOrderState>(
            builder: (context, ordersState) {
              return Column(
                children: [
                  searchOrderWidget(
                    context: context,
                    searchController: _searchController,
                    orderSearch: _orderSearch,
                    onSearch: (orderSearch) {
                      _orderSearch = orderSearch;
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
                                                  child: ordersView(
                                                      context: context,
                                                      state: ordersState),
                                                ),
                                                if (ordersState.totalPage > 1)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                                      orderSearch: _orderSearch.copyWith(
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
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                right: 8.0),
                                                        child: Text(
                                                          ordersState
                                                              .currentPage
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
                                                                      orderSearch: _orderSearch.copyWith(
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
                                                if (ordersState.selected !=
                                                    null)
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        minWidth: constraints
                                                            .maxWidth),
                                                    child: orderDetailWidget(
                                                        context: context,
                                                        token: user.token,
                                                        order: ordersState
                                                            .selected!),
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

  Widget ordersView(
      {required BuildContext context, required AllOrderLoaded state}) {
    return DataTable(
      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue),
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
          'Thao tác',
          style: AppStyle.h2,
        )),
      ],
      rows: [
        ...state.listOrder.asMap().entries.map((order) {
          return DataRow(
              color: (state.selected != null &&
                      state.selected!.orderID == order.value.orderID)
                  ? const MaterialStatePropertyAll(
                      Color.fromARGB(255, 201, 235, 238))
                  : (order.value.orderStatus.item_StatusID == 6)
                      ? const MaterialStatePropertyAll(
                          Color.fromARGB(255, 238, 211, 187))
                      : null,
              cells: [
                DataCell(Text(
                  order.value.orderID.toString(),
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  order.value.create_Date.split('T').first,
                  style: AppStyle.h2,
                )),
                DataCell(Tooltip(
                  message:
                      'Tiền hàng: ${NumberFormat.currency(locale: "vi-VN", decimalDigits: 0).format(order.value.priceItem)}\nTiền vận chuyển: ${NumberFormat.currency(locale: "vi-VN", decimalDigits: 0).format(order.value.feeShip)}',
                  child: Text(
                    NumberFormat.currency(locale: "vi-VN", decimalDigits: 0)
                        .format(order.value.priceItem + order.value.feeShip),
                    style: AppStyle.h2,
                  ),
                )),
                DataCell(InkWell(
                  child: Text(
                    order.value.name,
                    style: AppStyle.h2.copyWith(color: Colors.blue),
                  ),
                  onTap: () async => showDialog(
                    context: context,
                    builder: (context) => recipientInformationWidget(
                        controller: widget.sidebarXController,
                        firebaseid: order.value.firebaseID,
                        context: context,
                        name: order.value.name,
                        phone: order.value.tel,
                        address:
                            '${order.value.address}, ${order.value.ward},\n${order.value.district}, ${order.value.province}'),
                  ),
                )),
                DataCell(Text(
                  order.value.paymentMethod,
                  style: AppStyle.h2,
                )),
                DataCell(
                    Tooltip(
                      message:
                          '${order.value.orderShip.status}${(order.value.reason != null) ? '\n Lý dó: ${order.value.reason}' : ''}',
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          order.value.orderShip.status,
                          style: AppStyle.h2.copyWith(color: Colors.blue),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    onTap: () async => showDialog(
                          context: context,
                          builder: (context) => shipOrderWidget(
                              context: context,
                              serviceID: null,
                              orderID: order.value.orderID,
                              token: user.token),
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
                        // context
                        //     .read<OrderDetailCubit>()
                        //     .loadOrderDetail(order: order.value, token: user.token);
                        context.read<AllOrderBloc>().add(
                            OrderSelected(order: order.value, state: state));
                      },
                    ),
                    _videoPacking(order.value),
                    BlocProvider(
                      create: (context) => OrderTicketCubit(),
                      child: BlocConsumer<OrderTicketCubit, OrderTicketState>(
                        listener: (context, state) {
                          if (state is OrderTicketFailed) {
                            MyDialog.showSnackBar(context, state.msg);
                          }
                        },
                        builder: (context, orderTicketState) {
                          return InkWell(
                            child: (orderTicketState is OrderTicketLoading)
                                ? const CircularProgressIndicator()
                                : const Tooltip(
                                    message: 'Tải tem vận chuyển',
                                    child: Icon(
                                      Icons.download,
                                      color: Colors.blue,
                                    ),
                                  ),
                            onTap: () async {
                              context.read<OrderTicketCubit>().getTicker(
                                  orderID: order.value.orderID,
                                  token: user.token,
                                  onSuccess: (String data) {
                                    AnchorElement(
                                        href:
                                            "data:application/octet-stream;charset=utf-16le;base64,$data")
                                      ..setAttribute("download",
                                          "esmp_ship_${order.value.orderID}.pdf")
                                      ..click();
                                  });
                            },
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: (_orderSearch.shipOrderStatus == 1)
                          ? () async {
                              bool? success = await showDialog<bool>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => cancelOrderDialog(
                                    context: context,
                                    orderID: order.value.orderID,
                                    token: user.token),
                              );
                              if (success != null && success) {
                                if (mounted) {
                                  context.read<AllOrderBloc>().add(AllOrderLoad(
                                      orderSearch: _orderSearch,
                                      token: user.token));
                                }
                              }
                            }
                          : null,
                      child: Tooltip(
                        message: 'Huỷ đơn hàng',
                        child: Icon(
                          Icons.close,
                          color: (_orderSearch.shipOrderStatus == 1)
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )),
              ]);
        })
      ],
    );
  }

  _videoPacking(Order order) {
    return BlocProvider(
      create: (context) => OrderPackingVideoCubit(),
      child: BlocConsumer<OrderPackingVideoCubit, OrderPackingVideoState>(
        listener: (context, state) {
          if (state is OrderPackingVideoLoadFailed) {
            MyDialog.showSnackBar(context, state.msg);
          }
          if (state is OrderPackingVideoUpLoaded) {
            context.read<AllOrderBloc>().add(
                AllOrderLoad(orderSearch: _orderSearch, token: user.token));
          }
        },
        builder: (context, orderTicketState) {
          return InkWell(
            onTap: (orderTicketState is OrderPackingVideoLoading)
                ? null
                : () async {
                    if (order.packingLink != null) {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              VideoDialog(url: order.packingLink!));
                    } else {
                      context
                          .read<OrderPackingVideoCubit>()
                          .pickVideo(token: user.token, orderID: order.orderID);
                    }
                  },
            child: (orderTicketState is OrderPackingVideoLoading)
                ? const CircularProgressIndicator()
                : Tooltip(
                    message: (order.packingLink != null)
                        ? 'Xem video Đóng hàng'
                        : 'Đăng video đóng hàng',
                    child: const Icon(
                      Icons.upload,
                      color: Colors.blue,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
