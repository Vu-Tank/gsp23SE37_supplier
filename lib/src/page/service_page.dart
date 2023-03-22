import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/page/service/exchange_page.dart';
import 'package:gsp23se37_supplier/src/page/service/return_page.dart';

import '../utils/app_style.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 2,
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
                        'Đổi hàng',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Trả hàng',
                      style: AppStyle.buttom,
                    )),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  ExchangePage(),
                  ReturnPage(),
                ]),
              ),
            ],
          )),
    );
  }
}
