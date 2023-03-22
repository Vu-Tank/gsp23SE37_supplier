import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/bloc/shop/shop_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/update_store_info/update_store_info_cubit.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/page/store/store_edit_widget.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../model/store.dart';
import '../../utils/my_dialog.dart';

class StoreInfoDialog extends StatefulWidget {
  const StoreInfoDialog({super.key});

  @override
  State<StoreInfoDialog> createState() => _StoreInfoDialogState();
}

class _StoreInfoDialogState extends State<StoreInfoDialog> {
  late User user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthState authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      user = authState.user;
    } else {
      GoRouter.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, shopState) {
        if (shopState is ShopCreated) {
          Store store = shopState.store;
          return Dialog(
            child: BlocProvider(
              create: (context) => UpdateStoreInfoCubit(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Thông tin cửa hàng',
                    style: AppStyle.h2,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  BlocConsumer<UpdateStoreInfoCubit, UpdateStoreInfoState>(
                    listener: (context, state) {
                      if (state is UpdateStoreInfoSuccess) {
                        MyDialog.showAlertDialog(
                            context, "Cập nhập ảnh đại diện thành công");
                        // context
                        //     .read<ShopBloc>()
                        //     .add();
                      }
                    },
                    builder: (context, state) {
                      return Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.network(
                                (state is UpdateStoreInfoSuccess)
                                    ? state.store.image.path
                                    : store.image.path,
                                fit: BoxFit.cover),
                          ),
                          ElevatedButton(
                              onPressed: (state is UpdateStoreInfoLoading)
                                  ? null
                                  : () {
                                      context
                                          .read<UpdateStoreInfoCubit>()
                                          .updateImage(
                                              token: user.token, store: store);
                                    },
                              child: (state is UpdateStoreInfoLoading)
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Sửa',
                                      style: AppStyle.buttom,
                                    ))
                        ],
                      );
                    },
                  ),
                  DataTable(headingRowHeight: 0, columns: [
                    DataColumn(label: Container()),
                    DataColumn(label: Container()),
                  ], rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        'Tên cửa hàng',
                        style: AppStyle.h2,
                      )),
                      DataCell(
                        Text(
                          store.storeName,
                          style: AppStyle.h2,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => StoreEditWidget(
                                type: 'name', store: store, token: user.token),
                          );
                        },
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Email',
                        style: AppStyle.h2,
                      )),
                      DataCell(Text(
                        store.email,
                        style: AppStyle.h2,
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Ngày tham gia',
                        style: AppStyle.h2,
                      )),
                      DataCell(Text(
                        store.create_date.split('T')[0],
                        style: AppStyle.h2,
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Địa chỉ',
                        style: AppStyle.h2,
                      )),
                      DataCell(Text(
                        store.address.addressString(),
                        style: AppStyle.h2,
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Đánh giá',
                        style: AppStyle.h2,
                      )),
                      DataCell(
                        Row(
                          children: <Widget>[
                            RatingBarIndicator(
                              rating: store.totalRating,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              store.totalRating.toString(),
                              style: AppStyle.h2,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ])
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

// Widget storeInfoDialog({required BuildContext context, required Store store}) {}
