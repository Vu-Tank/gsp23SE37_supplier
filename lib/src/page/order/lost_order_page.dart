import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/model/order/order_search.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/store.dart';
import 'all_order_page.dart';

class LostOrderPage extends StatefulWidget {
  const LostOrderPage({super.key, required this.sidebarXController});
  final SidebarXController sidebarXController;

  @override
  State<LostOrderPage> createState() => _LostOrderPageState();
}

class _LostOrderPageState extends State<LostOrderPage> {
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
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AllOrderPage(
      orderSearch:
          OrderSearch(storeID: store.storeID, shipOrderStatus: 8, page: 1),
      sidebarXController: widget.sidebarXController,
    );
  }
}
