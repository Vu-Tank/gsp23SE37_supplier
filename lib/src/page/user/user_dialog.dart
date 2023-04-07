import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/bloc/auth/auth_bloc.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/page/user/user_edit_widget.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';

import '../../cubit/update_supplier_info/update_supplier_info_cubit.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({super.key});

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          User user = state.user;
          return Dialog(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                }),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: BlocProvider(
                    create: (context) => UpdateSupplierInfoCubit(),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(
                        'Thông tin nhà cung cấp',
                        style: AppStyle.h2,
                      ),
                      BlocConsumer<UpdateSupplierInfoCubit,
                          UpdateSupplierInfoState>(
                        listener: (context, state) {
                          if (state is UpdateSupplierInfoSuccess) {
                            MyDialog.showAlertDialog(
                                context, "Cập nhập ảnh đại diện thành công");
                            context
                                .read<AuthBloc>()
                                .add(UserUpdate(state.user));
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
                                    (state is UpdateSupplierInfoSuccess)
                                        ? state.user.image.path
                                        : user.image.path,
                                    fit: BoxFit.cover),
                              ),
                              ElevatedButton(
                                  onPressed: (state
                                          is UpdateSupplierInfoLoading)
                                      ? null
                                      : () {
                                          context
                                              .read<UpdateSupplierInfoCubit>()
                                              .updateImage(user: user);
                                        },
                                  child: (state is UpdateSupplierInfoLoading)
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
                            'Họ tên',
                            style: AppStyle.h2,
                          )),
                          DataCell(
                            Text(
                              user.userName,
                              style: AppStyle.h2,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    UserEditDialog(type: 'name', user: user),
                              );
                            },
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Ngày sinh',
                            style: AppStyle.h2,
                          )),
                          DataCell(
                            Text(
                              user.dateOfBirth.split('T')[0],
                              style: AppStyle.h2,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    UserEditDialog(type: 'dob', user: user),
                              );
                            },
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Giới tính',
                            style: AppStyle.h2,
                          )),
                          DataCell(
                            Text(
                              user.gender,
                              style: AppStyle.h2,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    UserEditDialog(type: 'gender', user: user),
                              );
                            },
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Email',
                            style: AppStyle.h2,
                          )),
                          DataCell(
                            Text(
                              user.email,
                              style: AppStyle.h2,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    UserEditDialog(type: 'email', user: user),
                              );
                            },
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Số điện thoại',
                            style: AppStyle.h2,
                          )),
                          DataCell(Text(
                            '+${user.phone}',
                            style: AppStyle.h2,
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Địa chỉ',
                            style: AppStyle.h2,
                          )),
                          DataCell(
                            Text(
                              user.addresses[0].addressString(),
                              style: AppStyle.h2,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    UserEditDialog(type: 'address', user: user),
                              );
                            },
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                            'Ngày tham gia',
                            style: AppStyle.h2,
                          )),
                          DataCell(Text(
                            user.crete_date.split('T')[0],
                            style: AppStyle.h2,
                          )),
                        ]),
                      ])
                    ]),
                  ),
                ),
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
