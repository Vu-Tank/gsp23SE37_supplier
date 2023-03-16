import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/page/order/canceled_page.dart';
import 'package:gsp23se37_supplier/src/page/order/delivered_page.dart';
import 'package:gsp23se37_supplier/src/page/order/delivering_page.dart';
import 'package:gsp23se37_supplier/src/page/order/received_ship_page.dart';
import 'package:gsp23se37_supplier/src/page/order/waiting_for_confirmation_page.dart';
import 'package:gsp23se37_supplier/src/page/order/waiting_for_the_goods_page.dart';

import '../utils/app_style.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 6,
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
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  WaitingForConfirmationPage(),
                  ReceivedShipPage(),
                  WaitingForTheGoodsPage(),
                  DeliveringPage(),
                  DeliveredPage(),
                  CanceledPage(),
                ]),
              ),
            ],
          )),
    );
  }
}
