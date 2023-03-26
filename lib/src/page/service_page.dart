import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/page/service/data_exchange_page.dart';
import 'package:gsp23se37_supplier/src/page/service/exchange_page.dart';
import 'package:gsp23se37_supplier/src/page/service/return_page.dart';
import 'package:sidebarx/sidebarx.dart';

import '../utils/app_style.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key, required this.sidebarXController});
  final SidebarXController sidebarXController;
  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
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
                    Tab(
                        child: Text(
                      'Đối soát',
                      style: AppStyle.buttom,
                    )),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [
                  ExchangePage(
                    sidebarXController: widget.sidebarXController,
                  ),
                  ReturnPage(sidebarXController: widget.sidebarXController),
                  const DataExchangePage(),
                ]),
              ),
            ],
          )),
    );
  }
}
