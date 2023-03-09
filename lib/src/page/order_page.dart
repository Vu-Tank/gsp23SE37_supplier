import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/page/order/all_order_page.dart';

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
          length: 1,
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
                        'Tất cả hoá đơn',
                        style: AppStyle.buttom,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  AllOrderPage(),
                ]),
              ),
            ],
          )),
    );
  }
}
