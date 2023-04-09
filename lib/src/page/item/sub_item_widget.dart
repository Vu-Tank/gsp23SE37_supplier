import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/cubit/item_detail/item_detail_cubit.dart';
import 'package:gsp23se37_supplier/src/model/item/item_detail.dart';
import 'package:gsp23se37_supplier/src/model/item/sub_item.dart';
import 'package:gsp23se37_supplier/src/page/item/edit_subitem_widget.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/my_dialog.dart';
import 'package:intl/intl.dart';

Widget subItemWidget(
    {required BuildContext context,
    required ItemDetail item,
    required int index,
    required bool edit,
    required String token}) {
  SubItem subItem = item.listSubItem[index];
  bool isUpdate = false;
  return Dialog(
    child: StatefulBuilder(
      builder: (context, setState) {
        return BlocProvider(
          create: (context) => ItemDetailCubit(),
          child: BlocConsumer<ItemDetailCubit, ItemDetailState>(
            listener: (context, state) {
              if (state is ItemDetailLoaded) {
                subItem = state.itemDetail.listSubItem[index];
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(
                        subItem.image.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    DataTable(columns: [
                      DataColumn(label: Container()),
                      DataColumn(label: Container()),
                    ], rows: [
                      DataRow(cells: [
                        DataCell(Text(
                          'Tên sản phẩm',
                          style: AppStyle.h2,
                        )),
                        DataCell(Text(
                          subItem.sub_ItemName,
                          style: AppStyle.h2,
                        )),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text(
                            'Giá',
                            style: AppStyle.h2,
                          ),
                        ),
                        DataCell(
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi-VN', decimalDigits: 0)
                                  .format(subItem.price),
                              style: AppStyle.h2,
                            ), onTap: () async {
                          SubItem? sub = await showDialog<SubItem>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => editSubItemWidget(
                                subItem: subItem, token: token, type: 'price'),
                          );

                          if (sub != null) {
                            setState(() {
                              isUpdate = true;
                              subItem = sub;
                            });
                          }
                        }),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          'Số lượng',
                          style: AppStyle.h2,
                        )),
                        DataCell(
                            Text(
                              subItem.amount.toString(),
                              style: AppStyle.h2,
                            ), onTap: () async {
                          SubItem? sub = await showDialog<SubItem>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => editSubItemWidget(
                                subItem: subItem, token: token, type: 'amount'),
                          );

                          if (sub != null) {
                            setState(() {
                              isUpdate = true;
                              subItem = sub;
                            });
                          }
                        }),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          'Khuyến mãi',
                          style: AppStyle.h2,
                        )),
                        DataCell(
                            Text(
                              '${subItem.discount}%',
                              style: AppStyle.h2,
                            ), onTap: () async {
                          SubItem? sub = await showDialog<SubItem>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => editSubItemWidget(
                                subItem: subItem,
                                token: token,
                                type: 'discount'),
                          );

                          if (sub != null) {
                            setState(() {
                              isUpdate = true;
                              subItem = sub;
                            });
                          }
                        }),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          'Bảo hành',
                          style: AppStyle.h2,
                        )),
                        DataCell(
                            Text(
                              '${subItem.warrantiesTime} Tháng',
                              style: AppStyle.h2,
                            ), onTap: () async {
                          SubItem? sub = await showDialog<SubItem>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => editSubItemWidget(
                                subItem: subItem,
                                token: token,
                                type: 'warrantiesTime'),
                          );

                          if (sub != null) {
                            setState(() {
                              isUpdate = true;
                              subItem = sub;
                            });
                          }
                        }),
                      ]),
                      DataRow(cells: [
                        DataCell(Text(
                          'Đổi trả',
                          style: AppStyle.h2,
                        )),
                        DataCell(
                            Text(
                              '${subItem.returnAndExchange} Ngày',
                              style: AppStyle.h2,
                            ), onTap: () async {
                          SubItem? sub = await showDialog<SubItem>(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => editSubItemWidget(
                                subItem: subItem,
                                token: token,
                                type: 'returnAndExchange'),
                          );

                          if (sub != null) {
                            setState(() {
                              isUpdate = true;
                              subItem = sub;
                            });
                          }
                        }),
                      ]),
                      DataRow(cells: [
                        DataCell(TextButton(
                            onPressed: () {
                              context.pop(isUpdate);
                            },
                            child: Text(
                              'Thoát',
                              style: AppStyle.textButtom,
                            ))),
                        DataCell((!edit || item.item_Status.item_StatusID != 1)
                            ? Container()
                            : TextButton(
                                onPressed: (state is ItemDetailLoading)
                                    ? null
                                    : () {
                                        if (item.listSubItem.length == 1) {
                                          MyDialog.showAlertDialogError(
                                              context, 'Không thể Dừng bán');
                                        } else {
                                          if (subItem.subItem_Status
                                                  .item_StatusID ==
                                              1) {
                                            context
                                                .read<ItemDetailCubit>()
                                                .hidenSubItem(
                                                    item: item,
                                                    token: token,
                                                    index: index);
                                          } else if (subItem.subItem_Status
                                                  .item_StatusID ==
                                              4) {
                                            context
                                                .read<ItemDetailCubit>()
                                                .unHidenSubItem(
                                                    item: item,
                                                    token: token,
                                                    index: index);
                                          }
                                        }
                                      },
                                child: (state is ItemDetailLoading)
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        (subItem.subItem_Status.item_StatusID ==
                                                1)
                                            ? 'Dừng bán'
                                            : 'Bán lại',
                                        style: AppStyle.textButtom
                                            .copyWith(color: Colors.red),
                                      ))),
                      ]),
                    ]),
                  ],
                ),
              );
            },
          ),
        );
      },
    ),
  );
}
