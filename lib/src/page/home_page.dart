import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/page_seleted/page_seleted_cubit.dart';
import 'package:gsp23se37_supplier/src/page/item_page.dart';
import 'package:gsp23se37_supplier/src/page/first_page.dart';
import 'package:gsp23se37_supplier/src/page/order_page.dart';
import 'package:gsp23se37_supplier/src/page/over_view/over_view_page.dart';
import 'package:gsp23se37_supplier/src/page/service/store_withdrawal_request_page.dart';
import 'package:gsp23se37_supplier/src/page/service_page.dart';
import 'package:gsp23se37_supplier/src/page/sidebar_widget.dart';
import 'package:gsp23se37_supplier/src/page/user/user_dialog.dart';
import 'package:gsp23se37_supplier/src/utils/min_size.dart';
import 'package:sidebarx/sidebarx.dart';

// ignore: avoid_web_libraries_in_flutter
// import 'dart:js' as js;
import 'dart:js' as js;
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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late SidebarXController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      context.read<AuthBloc>().add(AppLoaded());
    });

    controller = SidebarXController(selectedIndex: 0, extended: true);
    controller.addListener(() {
      if (controller.selectedIndex == 0) {
        setState(() {
          tiltie = "Trang Chủ";
        });
      }
      if (controller.selectedIndex == 1) {
        setState(() {
          tiltie = "Quản lý sản phẩm";
        });
      }
      if (controller.selectedIndex == 2) {
        setState(() {
          tiltie = "Quản lý đơn hàng";
        });
      }
      if (controller.selectedIndex == 3) {
        setState(() {
          tiltie = "Trò chuyện";
        });
      }
      if (controller.selectedIndex == 4) {
        setState(() {
          tiltie = "DỊch vụ";
        });
      }
      if (controller.selectedIndex == 5) {
        setState(() {
          tiltie = "Lịch sử rút tiền";
        });
      }
      if (controller.selectedIndex == 6) {
        setState(() {
          tiltie = "Giới thiệu";
        });
      }
    });
  }

  String tiltie = "Trang Chủ";
  @override
  Widget build(BuildContext context) {
    return MinSize(
      minHeight: window.physicalSize.height - 300,
      minWidth: window.physicalSize.width - 400,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            if (state.user.storeID != -1) {
              context.read<ShopBloc>().add(ShopLogin(
                  userID: state.user.userID, token: state.user.token));
            }
          }
        },
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            User user = state.user;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  tiltie,
                  style: AppStyle.apptitle,
                ),
                backgroundColor: AppStyle.appColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                actions: [
                  Row(
                    children: [
                      Text(
                        'Xin chào, ',
                        style: AppStyle.buttom,
                      ),
                      TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const UserDialog(),
                            );
                          },
                          child: Text(
                            user.userName,
                            style: AppStyle.buttom.copyWith(color: Colors.blue),
                          ))
                    ],
                  ),
                  TextButton(
                      onPressed: () =>
                          context.read<AuthBloc>().add(UserLoggedOut(user)),
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
                    : BlocBuilder<ShopBloc, ShopState>(
                        builder: (context, state) {
                          if (state is ShopCreated) {
                            Store store = state.store;
                            if (store.store_Status.item_StatusID == 1 ||
                                store.store_Status.item_StatusID == 4) {
                              return shopView(context, state.store);
                            } else {
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
                                        context
                                            .read<ShopBloc>()
                                            .add(ShopPayment(
                                                storeID: store.storeID,
                                                token: user.token,
                                                onSuccess: (String url) {
                                                  js.context.callMethod(
                                                      'open', [url, '_self']);
                                                }));
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
                                    onPressed: () {
                                      context.read<ShopBloc>().add(ShopLogin(
                                          userID: user.userID,
                                          token: user.token));
                                    },
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
                                            onSuccess: (String url) {
                                              js.context.callMethod(
                                                  'open', [url, '_self']);
                                            })),
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
            );
          } else if (state is AuthLoading) {
            return Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator()),
            );
          } else {
            return const FirstPage();
          }
        },
      ),
    );
  }

  Widget shopView(BuildContext context, Store store) {
    return Row(
      children: [
        SideBarWigdet(
          store: store,
          controller: controller,
        ),
        Expanded(child: BlocBuilder<PageSeletedCubit, PageSeletedState>(
          builder: (context, state) {
            return AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                switch (controller.selectedIndex) {
                  case 0:
                    return DashboardPage(
                      sidebarXController: controller,
                    );
                  case 1:
                    return ItemPage(
                      key: widget.key,
                      index: state.index,
                    );
                  case 2:
                    return OrderPage(
                      key: widget.key,
                      index: state.index,
                      sidebarXController: controller,
                    );
                  case 3:
                    return const ChatPage();
                  case 4:
                    return ServicePage(
                      sidebarXController: controller,
                    );
                  case 5:
                    return const StoreWithdrawalRequestPage();
                  case 6:
                    return const OverViewPage();
                  default:
                    return DashboardPage(
                      sidebarXController: controller,
                    );
                }
              },
            );
          },
        )),
      ],
    );
  }
}
