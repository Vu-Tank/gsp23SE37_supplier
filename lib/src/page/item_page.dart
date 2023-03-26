import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/page_seleted/page_seleted_cubit.dart';
import 'package:gsp23se37_supplier/src/page/item/add_item_page.dart';
import 'package:gsp23se37_supplier/src/page/item/item_active_page.dart';
import 'package:gsp23se37_supplier/src/page/item/item_hidden_page.dart';
import 'package:gsp23se37_supplier/src/page/item/item_pending_approval_page.dart';
import 'package:gsp23se37_supplier/src/page/item/items_block_page.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, this.index});
  final int? index;
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int? index;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    index = widget.index;
    context.read<PageSeletedCubit>().selectPage(index: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 5,
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
                        'Sản phẩm đang bán',
                        style: AppStyle.buttom,
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Thêm sản phẩm',
                      style: AppStyle.buttom,
                    )),
                    Tab(
                        child: Text(
                      'Sản phẩm chờ duyệt',
                      style: AppStyle.buttom,
                    )),
                    Tab(
                        child: Text(
                      'Sản phẩm dừng bán',
                      style: AppStyle.buttom,
                    )),
                    Tab(
                        child: Text(
                      'Sản phẩm Vi phạm',
                      style: AppStyle.buttom,
                    )),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(children: [
                  ItemActivePage(),
                  AddItemPage(),
                  ItemPendingApprovalPage(),
                  ItemHiddenPage(),
                  ItemBlockPage(),
                ]),
              ),
            ],
          )),
    );
  }
}
