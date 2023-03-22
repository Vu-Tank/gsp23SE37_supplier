import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/model/store.dart';
import 'package:gsp23se37_supplier/src/page/item/all_item_page.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/shop/shop_bloc.dart';
import '../../model/item/item_search.dart';
import '../../model/user.dart';
import '../../utils/app_constants.dart';

class ItemActivePage extends StatefulWidget {
  const ItemActivePage({super.key});

  @override
  State<ItemActivePage> createState() => _ItemActivePageState();
}

class _ItemActivePageState extends State<ItemActivePage> {
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
          } else {
            GoRouter.of(context).pushReplacementNamed('/');
          }
        } else {
          GoRouter.of(context).pushReplacementNamed('/');
        }
      } else {
        GoRouter.of(context).pushReplacementNamed('/');
      }
    } else {
      GoRouter.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AllItemPage(
        search: ItemSearch(
            sortBy: AppConstants.listSortModel.first.query,
            storeID: store.storeID,
            page: 1,
            itemStatusID: 1));
  }
}
