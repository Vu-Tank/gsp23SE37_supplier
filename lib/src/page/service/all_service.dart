import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/service_activity/service_activity_cubit.dart';
import 'package:gsp23se37_supplier/src/cubit/service_buy/service_buy_cubit.dart';
import 'package:gsp23se37_supplier/src/model/service/service_detail.dart';
import 'package:gsp23se37_supplier/src/model/service/service_search.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/page/service/cancel_service_dialog.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/service/service.dart';
import '../../model/store.dart';
import '../item/item_detail_widget.dart';
import '../order/recipient_information_wigdet.dart';
import '../video_dilog.dart';

class AllServicePage extends StatefulWidget {
  const AllServicePage(
      {super.key, required this.search, required this.sidebarXController});
  final ServiceSearch search;
  final SidebarXController sidebarXController;
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
                                                      list:
                                                          serviceBuyState.list,
                                                      state: serviceBuyState)),
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
                                                          : () {
                                                              context
                                                                  .read<
                                                                      ServiceBuyCubit>()
                                                                  .loadService(
                                                                      token: user
                                                                          .token,
                                                                      search: search.copyWith(
                                                                          page: search.page +
                                                                              1));
                                                            },
                                                      icon: const Icon(
                                                        Icons
                                                            .arrow_forward_outlined,
                                                        // color: Colors.black,
                                                      )),
                                                ],
                                              ),
                                              if (serviceBuyState.selected !=
                                                  null)
                                                ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        minWidth: constraints
                                                            .maxWidth),
                                                    child: serviceViewDetail(
                                                        context: context,
                                                        serviceBuy:
                                                            serviceBuyState
                                                                .selected!)),
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
      {required BuildContext context,
      required List<ServiceBuy> list,
      required ServiceBuyLoadSuccess state}) {
    return DataTable(
      showCheckboxColumn: false,
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
            'Mã đơn hàng',
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
            'Dịch vụ',
            style: AppStyle.h2,
          ),
        ),
        DataColumn(
            label: Text(
          'Trạng thái',
          style: AppStyle.h2,
        )),
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
          return DataRow(
              onSelectChanged: (value) {
                context
                    .read<ServiceBuyCubit>()
                    .selectService(serviceBuy: serviceBuy.value, state: state);
              },
              color: (state.selected != null &&
                      state.selected!.afterBuyServiceID ==
                          serviceBuy.value.afterBuyServiceID)
                  ? const MaterialStatePropertyAll(
                      Color.fromARGB(255, 194, 230, 235))
                  : null,
              cells: [
                DataCell(Text(
                  serviceBuy.value.afterBuyServiceID.toString(),
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  serviceBuy.value.orderID.toString(),
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  serviceBuy.value.create_Date.split('T').first,
                  style: AppStyle.h2,
                )),
                DataCell(Text(
                  serviceBuy.value.serviceType.statusName,
                  style: AppStyle.h2,
                )),
                DataCell(Tooltip(
                  message: (serviceBuy.value.reason != null)
                      ? serviceBuy.value.reason
                      : '',
                  child: Text(
                    (serviceBuy.value.orderShip != null)
                        ? serviceBuy.value.orderShip!.status
                        : serviceBuy.value.servicestatus.statusName,
                    style: AppStyle.h2,
                  ),
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
                        firebaseid: serviceBuy.value.firebaseID,
                        controller: widget.sidebarXController,
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
                        context.read<ServiceBuyCubit>().selectService(
                            serviceBuy: serviceBuy.value, state: state);
                      },
                    ),
                    InkWell(
                      child: const Tooltip(
                        message: 'Xem tình trạng hàng',
                        child: Icon(
                          Icons.video_file,
                          color: Colors.blue,
                        ),
                      ),
                      onTap: () async {
                        if (serviceBuy.value.packingLinkCus.isNotEmpty) {
                          log(serviceBuy.value.packingLinkCus);
                          showDialog(
                              context: context,
                              builder: (context) => VideoDialog(
                                  url: serviceBuy.value.packingLinkCus
                                      .replaceFirst('[', '')
                                      .replaceAll(']', '')));
                        } else {
                          MyDialog.showAlertDialog(context,
                              'Người mua không đăng tình tạng đơn hàng');
                        }
                      },
                    ),
                    BlocProvider(
                      create: (context) => ServiceActivityCubit(),
                      child: BlocConsumer<ServiceActivityCubit,
                          ServiceActivityState>(
                        listener: (context, state) {
                          if (state is ServiceActivityFailed) {
                            MyDialog.showSnackBar(context, state.msg);
                          } else if (state is ServiceActivitySuccess) {
                            context
                                .read<ServiceBuyCubit>()
                                .loadService(token: user.token, search: search);
                          }
                        },
                        builder: (context, state) {
                          return InkWell(
                            onTap:
                                (serviceBuy.value.servicestatus.item_StatusID ==
                                            2 ||
                                        serviceBuy.value.servicestatus
                                                .item_StatusID ==
                                            5)
                                    ? null
                                    : (state is ServiceActiviting)
                                        ? null
                                        : () async {
                                            context
                                                .read<ServiceActivityCubit>()
                                                .accept(
                                                    serviceID: serviceBuy.value
                                                        .afterBuyServiceID,
                                                    token: user.token);
                                          },
                            child: Tooltip(
                              message: 'Chập nhận',
                              child: (state is ServiceActiviting)
                                  ? const CircularProgressIndicator()
                                  : Icon(
                                      Icons.done,
                                      color: (serviceBuy.value.servicestatus
                                                      .item_StatusID ==
                                                  2 ||
                                              serviceBuy.value.servicestatus
                                                      .item_StatusID ==
                                                  5)
                                          ? Colors.grey
                                          : Colors.green,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: (serviceBuy.value.servicestatus.item_StatusID ==
                                  2 ||
                              serviceBuy.value.servicestatus.item_StatusID == 5)
                          ? null
                          : () async {
                              var check = await showDialog(
                                context: context,
                                builder: (context) => cancelServiceDialog(
                                    context: context,
                                    serviceId:
                                        serviceBuy.value.afterBuyServiceID,
                                    type: search.serviceType,
                                    token: user.token),
                              );
                              if (check != null) {
                                if (mounted) {
                                  context.read<ServiceBuyCubit>().loadService(
                                      token: user.token, search: search);
                                }
                              }
                            },
                      child: Tooltip(
                        message: 'Từ chối',
                        child: Icon(
                          Icons.cancel,
                          color:
                              (serviceBuy.value.servicestatus.item_StatusID ==
                                          2 ||
                                      serviceBuy.value.servicestatus
                                              .item_StatusID ==
                                          5)
                                  ? Colors.grey
                                  : Colors.red,
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

  Widget serviceViewDetail(
      {required BuildContext context, required ServiceBuy serviceBuy}) {
    return LayoutBuilder(builder: (context, size) {
      return Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          const Divider(
            color: Colors.black,
            height: 2,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'Chi tiết dịch vụ ${serviceBuy.afterBuyServiceID}',
            style: AppStyle.h2,
          ),
          const SizedBox(
            height: 8.0,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: size.maxWidth),
            child: DataTable(
              showCheckboxColumn: false,
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.blue),
              columns: [
                DataColumn(
                    label: Text(
                  'Tên sản phẩm',
                  style: AppStyle.h2,
                )),
                DataColumn(
                    label: Text(
                  'Số lượng',
                  style: AppStyle.h2,
                )),
                DataColumn(
                    label: Text(
                  'Đơn giá',
                  style: AppStyle.h2,
                )),
                DataColumn(
                    label: Text(
                  'Khuyến mãi',
                  style: AppStyle.h2,
                )),
                DataColumn(
                    label: Text(
                  'Hình ảnh',
                  style: AppStyle.h2,
                )),
              ],
              rows: List.generate(serviceBuy.details.length, (index) {
                ServiceDetail detail = serviceBuy.details[index];
                return DataRow(
                  cells: [
                    DataCell(Tooltip(
                      message: detail.sub_ItemName,
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          detail.sub_ItemName,
                          style: AppStyle.h2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
                    DataCell(Text(
                      detail.amount.toString(),
                      style: AppStyle.h2,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    )),
                    DataCell(Text(
                      NumberFormat.currency(locale: 'vi-VN', decimalDigits: 0)
                          .format(detail.pricePurchase),
                      style: AppStyle.h2,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    )),
                    DataCell(Text(
                      '${detail.discountPurchase * 100} %',
                      style: AppStyle.h2.copyWith(
                          color: (detail.discountPurchase != 0)
                              ? Colors.red
                              : Colors.black),
                    )),
                    DataCell(
                      SizedBox(
                        width: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            detail.sub_ItemImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    SizedBox(
                                      height: 500,
                                      width: 500,
                                      child: Image.network(detail.sub_ItemImage,
                                          fit: BoxFit.cover),
                                    ),
                                    IconButton(
                                        onPressed: () => context.pop(),
                                        icon: const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              )),
                    ),
                  ],
                  onSelectChanged: (value) => showDialog(
                    context: context,
                    builder: (context) => ItemDetailWidget(
                        itemId: detail.itemID, token: user.token, edit: false),
                  ),
                );
              }),
            ),
          )
        ],
      );
    });
  }

  Widget serviceSearch({required BuildContext context}) {
    return Row(
      children: [
        OutlinedButton(
            onPressed: () {},
            child: Text(
              'Từ ngày',
              style: AppStyle.textButtom,
            )),
        OutlinedButton(
            onPressed: () {},
            child: Text(
              'Từ ngày',
              style: AppStyle.textButtom,
            )),
      ],
    );
  }
}
