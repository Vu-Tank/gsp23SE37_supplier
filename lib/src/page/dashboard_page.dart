import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/page_seleted/page_seleted_cubit.dart';
import 'package:gsp23se37_supplier/src/page/store/cash_flow_dialog.dart';
import 'package:gsp23se37_supplier/src/page/store/store_withdrawal_dialog.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:intl/intl.dart';
import 'package:sidebarx/sidebarx.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/shop/shop_bloc.dart';
import '../cubit/item_hot/item_hot_cubit.dart';
import '../model/item/item.dart';
import '../model/store.dart';
import '../model/user.dart';
import '../utils/my_dialog.dart';
import '../widget/bloc_load_failed.dart';
import 'bar_chart.dart';
import 'item/item_detail_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.sidebarXController});
  final SidebarXController sidebarXController;
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Store store;
  late User user;
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
          } else {
            // context.read<AuthBloc>().add(AppLoaded());
          }
        } else {
          // context.read<AuthBloc>().add(AppLoaded());
        }
      } else {
        // context.read<AuthBloc>().add(AppLoaded());
      }
    } else {
      // context.read<AuthBloc>().add(AppLoaded());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LayoutBuilder(
          builder: (p0, p1) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: p1.maxHeight,
                  maxWidth: 300,
                  minWidth: 300,
                  minHeight: 300),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Card(
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tài khoản',
                          style: AppStyle.h2,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: Text(
                            NumberFormat.currency(
                                    locale: 'vi-VN', decimalDigits: 0)
                                .format(store.asset),
                            style: AppStyle.h2,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    if (store.asset < 10000) {
                                      MyDialog.showAlertDialog(context,
                                          'Số tiền Phải lơn hơn 10.000VNĐ mới có thể rút');
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            storeWithdraWalDialog(
                                                context: context,
                                                user: user,
                                                store: store),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Rút tiền',
                                    style: AppStyle.textButtom,
                                  )),
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CashFlowDialog(
                                          storeID: store.storeID,
                                          token: user.token),
                                    );
                                  },
                                  child: Text(
                                    'Dòng tiền',
                                    style: AppStyle.textButtom,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Center(
                          child: Text(
                            'Top sản phẩm',
                            style: AppStyle.h2,
                          ),
                        ),
                        Expanded(
                          child: BlocProvider(
                            create: (context) => ItemHotCubit()
                              ..loadHotItem(
                                  token: user.token, storeID: store.storeID),
                            child: BlocBuilder<ItemHotCubit, ItemHotState>(
                              builder: (context, state) {
                                if (state is ItemHotLoaded) {
                                  if (state.list.isEmpty) {
                                    return Text(
                                      'Không có dữ liệu',
                                      style: AppStyle.h2,
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              state.list.length, (index) {
                                            Item item = state.list[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        ItemDetailWidget(
                                                            itemId: item.itemID,
                                                            token: user.token,
                                                            edit: false),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: Image.network(
                                                          item.item_Image),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item.name,
                                                        style: AppStyle.h2,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    );
                                  }
                                } else if (state is ItemHotFailed) {
                                  return blocLoadFailed(
                                    msg: state.msg,
                                    reload: () {
                                      context.read<ItemHotCubit>().loadHotItem(
                                          token: user.token,
                                          storeID: store.storeID);
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ]),
            );
          },
        ),
        // Column(
        //   children: [
        //     Card(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text(
        //             'Tài khoản',
        //             style: AppStyle.h2,
        //           ),
        //           const SizedBox(
        //             height: 8.0,
        //           ),
        //           Container(
        //             decoration: BoxDecoration(
        //               border: Border.all(),
        //             ),
        //             child: Text(
        //               NumberFormat.currency(locale: 'vi-VN', decimalDigits: 0)
        //                   .format(store.asset),
        //               style: AppStyle.h2,
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 8.0,
        //           ),
        //           // Row(
        //           //   children: [
        //           //     TextButton(
        //           //         onPressed: () {
        //           //           if (store.asset < 10000) {
        //           //             MyDialog.showAlertDialog(context,
        //           //                 'Số tiền Phải lơn hơn 10.000VNĐ mới có thể rút');
        //           //           } else {
        //           //             showDialog(
        //           //               context: context,
        //           //               builder: (context) => storeWithdraWalDialog(
        //           //                   context: context, user: user, store: store),
        //           //             );
        //           //           }
        //           //         },
        //           //         child: Text(
        //           //           'Rút tiền',
        //           //           style: AppStyle.textButtom,
        //           //         )),
        //           //     TextButton(
        //           //         onPressed: () {
        //           //           showDialog(
        //           //             context: context,
        //           //             builder: (context) => CashFlowDialog(
        //           //                 storeID: store.storeID, token: user.token),
        //           //           );
        //           //         },
        //           //         child: Text(
        //           //           'Dòng tiền',
        //           //           style: AppStyle.textButtom,
        //           //         )),
        //           //   ],
        //           // )
        //         ],
        //       ),
        //     ),
        //     Card(
        //       child: Column(children: [
        //         SizedBox(
        //           width: 300,
        //           child: Center(
        //             child: Text(
        //               'Top sản phẩm',
        //               style: AppStyle.h2,
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: BlocProvider(
        //             create: (context) => ItemHotCubit()
        //               ..loadHotItem(token: user.token, storeID: store.storeID),
        //             child: BlocBuilder<ItemHotCubit, ItemHotState>(
        //               builder: (context, state) {
        //                 if (state is ItemHotLoaded) {
        //                   if (state.list.isEmpty) {
        //                     return Text(
        //                       'Không có dữ liệu',
        //                       style: AppStyle.h2,
        //                     );
        //                   } else {
        //                     return Padding(
        //                       padding: const EdgeInsets.all(8.0),
        //                       child: ConstrainedBox(
        //                         constraints: const BoxConstraints(
        //                             minHeight: 200,
        //                             minWidth: 200,
        //                             // maxHeight: 300,
        //                             maxWidth: 300),
        //                         child: SingleChildScrollView(
        //                           child: Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: List.generate(state.list.length,
        //                                 (index) {
        //                               Item item = state.list[index];
        //                               return Padding(
        //                                 padding: const EdgeInsets.symmetric(
        //                                     vertical: 8.0),
        //                                 child: InkWell(
        //                                   onTap: () {
        //                                     showDialog(
        //                                       context: context,
        //                                       builder: (context) =>
        //                                           ItemDetailWidget(
        //                                               itemId: item.itemID,
        //                                               token: user.token,
        //                                               edit: false),
        //                                     );
        //                                   },
        //                                   child: Row(
        //                                     children: [
        //                                       SizedBox(
        //                                         height: 50,
        //                                         width: 50,
        //                                         child: Image.network(
        //                                             item.item_Image),
        //                                       ),
        //                                       Expanded(
        //                                         child: Text(
        //                                           item.name,
        //                                           style: AppStyle.h2,
        //                                           maxLines: 1,
        //                                           overflow:
        //                                               TextOverflow.ellipsis,
        //                                         ),
        //                                       )
        //                                     ],
        //                                   ),
        //                                 ),
        //                               );
        //                             }),
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   }
        //                 } else if (state is ItemHotFailed) {
        //                   return blocLoadFailed(
        //                     msg: state.msg,
        //                     reload: () {
        //                       context.read<ItemHotCubit>().loadHotItem(
        //                           token: user.token, storeID: store.storeID);
        //                     },
        //                   );
        //                 } else {
        //                   return const Center(
        //                     child: CircularProgressIndicator(),
        //                   );
        //                 }
        //               },
        //             ),
        //           ),
        //         ),
        //       ]),
        //     )
        //   ],
        // ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context.read<PageSeletedCubit>().selectPage(index: 0);
                        widget.sidebarXController.selectIndex(1);
                      },
                      child: SizedBox(
                        height: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sản phẩm đang bán',
                                style: AppStyle.h2,
                              ),
                              Text(
                                store.totalActiveItem.toString(),
                                style: AppStyle.h2,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context.read<PageSeletedCubit>().selectPage(index: 2);
                        widget.sidebarXController.selectIndex(1);
                      },
                      child: SizedBox(
                        height: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sản phẩm chờ duyệt',
                                style: AppStyle.h2,
                              ),
                              Text(
                                store.totalWatingItem.toString(),
                                style: AppStyle.h2,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context.read<PageSeletedCubit>().selectPage(index: 4);
                        widget.sidebarXController.selectIndex(1);
                      },
                      child: SizedBox(
                        height: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sản phẩm vi phạm',
                                style: AppStyle.h2,
                              ),
                              Text(
                                store.totalBlockItem.toString(),
                                style: AppStyle.h2,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context
                            .read<PageSeletedCubit>()
                            .selectPage(index: null);
                        widget.sidebarXController.selectIndex(2);
                      },
                      child: SizedBox(
                        height: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Đơn hàng',
                                style: AppStyle.h2,
                              ),
                              Text(
                                store.totalOrder.toString(),
                                style: AppStyle.h2,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context.read<PageSeletedCubit>().selectPage(index: 5);
                        widget.sidebarXController.selectIndex(2);
                      },
                      child: SizedBox(
                        height: 150,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'đơn huỷ',
                                style: AppStyle.h2,
                              ),
                              Text(
                                store.totalCancelOrder.toString(),
                                style: AppStyle.h2,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ]),
              Expanded(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomerBarChart(
                    storeID: store.storeID,
                    token: user.token,
                  ),
                ),
              ))
            ],
          ),
        )
      ],
    );
  }
}
