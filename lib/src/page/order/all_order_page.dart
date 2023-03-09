import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/bloc/all_order/all_order_bloc.dart';
import 'package:gsp23se37_supplier/src/model/order.dart';
import 'package:gsp23se37_supplier/src/model/order_detail.dart';
import 'package:gsp23se37_supplier/src/model/order_search.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/store.dart';

class AllOrderPage extends StatefulWidget {
  const AllOrderPage({super.key});

  @override
  State<AllOrderPage> createState() => _AllOrderPageState();
}

class _AllOrderPageState extends State<AllOrderPage> {
  late Store store;
  late User user;
  OrderSearch _orderSearch = OrderSearch();
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
                storeID: store.storeID, shipOrderStatus: 1, page: 1);
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
          )
        ],
        child: Center(
          child: BlocBuilder<AllOrderBloc, AllOrderState>(
            builder: (context, ordersState) {
              if (ordersState is AllOrderLoadFailed) {
                return blocLoadFailed(
                  msg: ordersState.msg,
                  reload: () => context.read<AllOrderBloc>().add(AllOrderLoad(
                      orderSearch: _orderSearch, token: user.token)),
                );
              } else if (ordersState is AllOrderLoaded) {
                if (ordersState.listOrder.isEmpty) {
                  return Text(
                    'Chưa có đơn hàng',
                    style: AppStyle.h2,
                  );
                } else {
                  return Container(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Table(
                              border: TableBorder.all(),
                              children: List.generate(
                                  ordersState.listOrder.length, (index) {
                                Order order = ordersState.listOrder[index];
                                return TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Mã đơn hàng: ${order.orderID.toString()}',
                                          style: AppStyle.h3,
                                        ),
                                        Text(
                                          'Ngày đặt: ${order.create_Date.replaceAll('T', ' ').toString().split('.')[0]}',
                                          style: AppStyle.h3,
                                        ),
                                        Text(
                                          'Mã vận đơn: ${order.orderShip.labelID}',
                                          style: AppStyle.h3,
                                        ),
                                        Text(
                                          'Tiền hàng: ${order.priceItem.toString()} VND',
                                          style: AppStyle.h3,
                                        ),
                                        Text(
                                          'Tiền vận chuyển: ${order.feeShip.toString()} VND',
                                          style: AppStyle.h3,
                                        ),
                                        Text(
                                          'Trạng thái: ${order.orderShip.status}',
                                          style: AppStyle.h3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Họ tên: ${order.name}',
                                          style: AppStyle.h3,
                                        ),
                                        Text(
                                          'SĐT: ${order.tel}',
                                          style: AppStyle.h3,
                                        ),
                                        Text(
                                          'Địa chỉ: ${order.address}, ${order.ward}, ${order.district}, ${order.province}',
                                          style: AppStyle.h3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      ListView.builder(
                                        itemCount: order.details.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          OrderDetail orderDetail =
                                              order.details[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.network(
                                                      orderDetail.sub_ItemImage,
                                                      fit: BoxFit.cover),
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      orderDetail.sub_ItemName,
                                                      style: AppStyle.h3,
                                                    ),
                                                    Text(
                                                      'Số lượng: ${orderDetail.amount}',
                                                      style: AppStyle.h3,
                                                    ),
                                                    Text(
                                                      'Tiền hàng: ${orderDetail.pricePurchase}',
                                                      style: AppStyle.h3,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ]);
                              })),
                          // ListView.builder(
                          //   scrollDirection: Axis.vertical,
                          //   physics: const NeverScrollableScrollPhysics(),
                          //   shrinkWrap: true,
                          //   itemCount: ordersState.listOrder.length,
                          //   itemBuilder: (context, index) {
                          //     Order order = ordersState.listOrder[index];
                          //     return Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Row(
                          //         children: [
                          //           Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 'Mã đơn hàng: ${order.orderID.toString()}',
                          //                 style: AppStyle.h3,
                          //               ),
                          //               Text(
                          //                 'Ngày đặt: ${order.create_Date.replaceAll('T', ' ').toString().split('.')[0]}',
                          //                 style: AppStyle.h3,
                          //               ),
                          //               Text(
                          //                 'Mã vận đơn: ${order.orderShip.labelID}',
                          //                 style: AppStyle.h3,
                          //               ),
                          //               Text(
                          //                 'Tiền hàng: ${order.priceItem.toString()} VND',
                          //                 style: AppStyle.h3,
                          //               ),
                          //               Text(
                          //                 'Tiền vận chuyển: ${order.feeShip.toString()} VND',
                          //                 style: AppStyle.h3,
                          //               ),
                          //               Text(
                          //                 'Trạng thái: ${order.orderShip.status}',
                          //                 style: AppStyle.h3,
                          //               ),
                          //             ],
                          //           ),
                          //           const SizedBox(width: 8.0),
                          //           Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 'Họ tên: ${order.name}',
                          //                 style: AppStyle.h3,
                          //               ),
                          //               Text(
                          //                 'SĐT: ${order.tel}',
                          //                 style: AppStyle.h3,
                          //               ),
                          //               Text(
                          //                 'Địa chỉ: ${order.address}, ${order.ward}, ${order.district}, ${order.province}',
                          //                 style: AppStyle.h3,
                          //               ),
                          //             ],
                          //           )
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    // color: Colors.black,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  ordersState.currentPage.toString(),
                                  style: AppStyle.h2,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_forward_outlined,
                                    // color: Colors.black,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
