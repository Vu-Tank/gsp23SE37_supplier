import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/item/item_search.dart';
import '../../model/store.dart';
import '../../model/user.dart';
import '../../utils/app_constants.dart';
import 'all_item_page.dart';

class ItemHiddenPage extends StatefulWidget {
  const ItemHiddenPage({super.key});

  @override
  State<ItemHiddenPage> createState() => _ItemHiddenPageState();
}

class _ItemHiddenPageState extends State<ItemHiddenPage> {
  late Store store;
  late User user;
  @override
  void initState() {
    // TODO: implement initState
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
    return AllItemPage(
        search: ItemSearch(
            sortBy: AppConstants.listSortModel.first.query,
            storeID: store.storeID,
            page: 1,
            itemStatusID: 4));
  }
}
