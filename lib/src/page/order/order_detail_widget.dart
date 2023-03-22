import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/model/order/order.dart';
import 'package:intl/intl.dart';

import '../../model/order/order_detail.dart';
import '../../utils/app_style.dart';
import '../item/item_detail_widget.dart';
import 'feedback_dialog.dart';

Widget orderDetailWidget(
    {required BuildContext context,
    required Order order,
    required String token}) {
  return LayoutBuilder(builder: (context, constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: constraints.maxWidth),
      child: Column(
        children: [
          const Divider(
            color: Colors.black,
            height: 2,
          ),
          Text(
            'Chi tiết đơn hằng ${order.orderID}',
            style: AppStyle.h2,
          ),
          DataTable(
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                  label: Text(
                'Tên sản phẩm',
                style: AppStyle.h2,
              )),
              DataColumn(
                  label: Text(
                'Số lượng',
                style: AppStyle.h2,
              )),
              DataColumn(
                  label: Text(
                'Đơn giá',
                style: AppStyle.h2,
              )),
              DataColumn(
                  label: Text(
                'Khuyến mãi',
                style: AppStyle.h2,
              )),
              DataColumn(
                  label: Text(
                'Bảo hành',
                style: AppStyle.h2,
              )),
              DataColumn(
                  label: Text(
                'Đổi trả',
                style: AppStyle.h2,
              )),
              DataColumn(
                  label: Text(
                'Hình ảnh',
                style: AppStyle.h2,
              )),
              DataColumn(
                  label: Text(
                'Đánh giá',
                style: AppStyle.h2,
              )),
            ],
            rows: List.generate(order.details.length, (index) {
              OrderDetail detail = order.details[index];
              return DataRow(
                cells: [
                  DataCell(Tooltip(
                    message: detail.sub_ItemName,
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        detail.sub_ItemName,
                        style: AppStyle.h2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )),
                  DataCell(Text(
                    detail.amount.toString(),
                    style: AppStyle.h2,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  )),
                  DataCell(Text(
                    NumberFormat.currency(locale: 'vi-VN', decimalDigits: 0)
                        .format(detail.pricePurchase),
                    style: AppStyle.h2,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  )),
                  DataCell(Text(
                    '${detail.discountPurchase * 100} %',
                    style: AppStyle.h2.copyWith(
                        color: (detail.discountPurchase != 0)
                            ? Colors.red
                            : Colors.black),
                  )),
                  DataCell(Text(
                    '${detail.warrantiesTime}',
                    style: AppStyle.h2,
                  )),
                  DataCell(Text(
                    '${detail.returnAndExchange}',
                    style: AppStyle.h2,
                  )),
                  DataCell(
                    SizedBox(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          detail.sub_ItemImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  SizedBox(
                                    height: 500,
                                    width: 500,
                                    child: Image.network(detail.sub_ItemImage,
                                        fit: BoxFit.cover),
                                  ),
                                  IconButton(
                                      onPressed: () => context.pop(),
                                      icon: const Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            )),
                  ),
                  DataCell(
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: (detail.feedBack_Date != null)
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    onTap: (detail.feedBack_Date != null)
                        ? () => showDialog(
                              context: context,
                              builder: (context) => feedbackOrderDialog(
                                  context: context, orderDetail: detail),
                            )
                        : null,
                  ),
                ],
                onSelectChanged: (value) => showDialog(
                  context: context,
                  builder: (context) =>
                      ItemDetailWidget(itemId: detail.itemID, token: token),
                ),
              );
            }),
          )
        ],
      ),
    );
  });
}
