import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/page_seleted/page_seleted_cubit.dart';
import 'package:gsp23se37_supplier/src/page/order/canceled_page.dart';
import 'package:gsp23se37_supplier/src/page/order/delivered_page.dart';
import 'package:gsp23se37_supplier/src/page/order/delivering_page.dart';
import 'package:gsp23se37_supplier/src/page/order/lost_order_page.dart';
import 'package:gsp23se37_supplier/src/page/order/received_ship_page.dart';
import 'package:gsp23se37_supplier/src/page/order/waiting_for_confirmation_page.dart';
import 'package:gsp23se37_supplier/src/page/order/waiting_for_the_goods_page.dart';
import 'package:sidebarx/sidebarx.dart';

import '../utils/app_style.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, this.index, required this.sidebarXController});
  final int? index;
  final SidebarXController sidebarXController;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int? index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
    context.read<PageSeletedCubit>().selectPage(index: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 7,
          initialIndex: (index != null) ? index! : 0,
          child: Column(
            children: [
              Container(
                color: AppStyle.appColor,
                child: TabBar(
                  labelStyle: AppStyle.buttom,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      child: Text(
                        'Đang xử lý',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Đã tiếp nhận',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Chờ lấy hàng',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Đang giao',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Đã giao',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Đã Huỷ',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Bị mất',
                        style: AppStyle.buttom,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  WaitingForConfirmationPage(
                      sidebarXController: widget.sidebarXController),
                  ReceivedShipPage(
                      sidebarXController: widget.sidebarXController),
                  WaitingForTheGoodsPage(
                      sidebarXController: widget.sidebarXController),
                  DeliveringPage(sidebarXController: widget.sidebarXController),
                  DeliveredPage(sidebarXController: widget.sidebarXController),
                  CanceledPage(sidebarXController: widget.sidebarXController),
                  LostOrderPage(sidebarXController: widget.sidebarXController),
                ]),
              ),
            ],
          )),
    );
  }
}
