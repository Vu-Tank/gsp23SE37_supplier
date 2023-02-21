import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/page/sidebar_widget.dart';
import 'package:sidebarx/sidebarx.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/shop/shop_bloc.dart';
import '../model/store.dart';
import '../model/user.dart';
import '../router/app_router_constants.dart';
import '../utils/app_style.dart';
import 'chat_page.dart';
import 'dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          User user = state.user;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Trang chủ',
                style: AppStyle.apptitle,
              ),
              backgroundColor: AppStyle.appColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: [
                ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(UserLoggedOut());
                    },
                    style: AppStyle.myButtonStyle.copyWith(
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.white)))),
                    child: Text(
                      'Đăng xuất',
                      style: AppStyle.buttom,
                    )),
              ],
            ),
            body: Center(
              child: (state.user.storeID == -1)
                  ? Column(children: [
                      Text(
                        'Bạn chưa tiến hành tạo cửa hàng!',
                        style: AppStyle.h2,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 56.0,
                        width: 150.0,
                        child: ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(AppRouterConstants.registerStore);
                          },
                          style: AppStyle.myButtonStyle,
                          child: Text(
                            'Tạo cửa hàng',
                            style: AppStyle.buttom,
                          ),
                        ),
                      ),
                    ])
                  : BlocProvider(
                      create: (context) => ShopBloc()
                        ..add(
                          ShopLogin(userID: user.userID, token: user.token),
                        ),
                      child: BlocBuilder<ShopBloc, ShopState>(
                        builder: (context, state) {
                          if (state is ShopCreated) {
                            Store store = state.store;
                            inspect(store);
                            if (store.store_Status.item_StatusID == 1) {
                              return shopView(context, state.store);
                            } else {
                              // return BlocProvider(
                              //   create: (context) => ShopPaymentCubit(),
                              //   child: BlocBuilder<ShopPaymentCubit,
                              //       ShopPaymentState>(
                              //     builder: (context, shopPaymentState) {
                              //       if (shopPaymentState
                              //           is ShopPaymentLoadFaild) {
                              //         return Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: <Widget>[
                              //             Text(
                              //               shopPaymentState.msg,
                              //               style: AppStyle.h2
                              //                   .copyWith(color: Colors.red),
                              //             ),
                              //             const SizedBox(
                              //               height: 8.0,
                              //             ),
                              //             SizedBox(
                              //               height: 56.0,
                              //               width: 300,
                              //               child: ElevatedButton(
                              //                 onPressed: (shopPaymentState
                              //                         is ShopPaymentLoading)
                              //                     ? null
                              //                     : () {
                              //                         context
                              //                             .read<
                              //                                 ShopPaymentCubit>()
                              //                             .loadPaymentDialog();
                              //                       },
                              //                 style: AppStyle.myButtonStyle,
                              //                 child: (shopPaymentState
                              //                         is ShopPaymentLoading)
                              //                     ? const CircularProgressIndicator()
                              //                     : Text(
                              //                         'Thử lại',
                              //                         style: AppStyle.buttom,
                              //                       ),
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //       }
                              //       if (shopPaymentState is ShopPaymentLoaded) {
                              //         return Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: <Widget>[
                              //             Text(
                              //               'Bạn chưa trả phí tham gia vào hệ thống ESMP',
                              //               style: AppStyle.h2,
                              //             ),
                              //             const SizedBox(
                              //               height: 8.0,
                              //             ),
                              //             SizedBox(
                              //               height: 56.0,
                              //               width: 300,
                              //               child: ElevatedButton(
                              //                 onPressed: () {},
                              //                 style: AppStyle.myButtonStyle,
                              //                 child: Text(
                              //                   'Thanh toán',
                              //                   style: AppStyle.buttom,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //       }
                              //       return Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: <Widget>[
                              //           Text(
                              //             'Bạn chưa trả phí tham gia vào hệ thống ESMP',
                              //             style: AppStyle.h2,
                              //           ),
                              //           const SizedBox(
                              //             height: 8.0,
                              //           ),
                              //           SizedBox(
                              //             height: 56.0,
                              //             width: 300,
                              //             child: ElevatedButton(
                              //               onPressed: (shopPaymentState
                              //                       is ShopPaymentLoading)
                              //                   ? null
                              //                   : () {
                              //                       context
                              //                           .read<
                              //                               ShopPaymentCubit>()
                              //                           .loadPaymentDialog();
                              //                     },
                              //               style: AppStyle.myButtonStyle,
                              //               child: (shopPaymentState
                              //                       is ShopPaymentLoading)
                              //                   ? const CircularProgressIndicator()
                              //                   : Text(
                              //                       'Thanh toán',
                              //                       style: AppStyle.buttom,
                              //                     ),
                              //             ),
                              //           ),
                              //         ],
                              //       );
                              //     },
                              //   ),
                              // );
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Bạn chưa trả phí tham gia vào hệ thống ESMP',
                                    style: AppStyle.h2,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Bạn cần thanh toán ${state.priceActice}VNĐ',
                                    style: AppStyle.h2,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  SizedBox(
                                    height: 56.0,
                                    width: 300,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<ShopBloc>().add(
                                            ShopPayment(
                                                storeID: store.storeID,
                                                token: user.token,
                                                onSuccess: () {}));
                                      },
                                      style: AppStyle.myButtonStyle,
                                      child: Text(
                                        'Thanh toán',
                                        style: AppStyle.buttom,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else if (state is ShopLoginFailed) {
                            return Center(
                              child: Column(children: [
                                Text(
                                  state.msg,
                                  style:
                                      AppStyle.h2.copyWith(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 54.0,
                                  width: 350,
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<ShopBloc>()
                                        .add(ShopLogin(
                                            userID: user.userID,
                                            token: user.token)),
                                    style: AppStyle.myButtonStyle,
                                    child: Text(
                                      'Thử lại',
                                      style: AppStyle.buttom,
                                    ),
                                  ),
                                )
                              ]),
                            );
                          } else if (state is ShopPaymentFailed) {
                            return Center(
                              child: Column(children: [
                                Text(
                                  state.msg,
                                  style:
                                      AppStyle.h2.copyWith(color: Colors.red),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                SizedBox(
                                  height: 54.0,
                                  width: 350,
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<ShopBloc>()
                                        .add(ShopPayment(
                                            storeID: state.storeID,
                                            token: user.token,
                                            onSuccess: () {})),
                                    style: AppStyle.myButtonStyle,
                                    child: Text(
                                      'Thử lại',
                                      style: AppStyle.buttom,
                                    ),
                                  ),
                                )
                              ]),
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
          );
        } else if (state is AuthLoading) {
          return Scaffold(
            body: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context)
                                  .pushNamed(AppRouterConstants.loginRouteName);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyle.appColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Text(
                              'Đăng nhập',
                              style: AppStyle.buttom,
                            )),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                  AppRouterConstants.registerRouteName);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppStyle.appColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            child: Text(
                              'Đăng ký',
                              style: AppStyle.buttom,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget shopView(BuildContext context, Store store) {
    final controller = SidebarXController(selectedIndex: 0, extended: true);
    return Row(
      children: [
        SideBarWigdet(
          store: store,
          controller: controller,
        ),
        Expanded(
            child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            switch (controller.selectedIndex) {
              case 0:
                return const DashboardPage();
              case 1:
                return const ChatPage();
              default:
                return const DashboardPage();
            }
          },
        )),
      ],
    );
  }
}
