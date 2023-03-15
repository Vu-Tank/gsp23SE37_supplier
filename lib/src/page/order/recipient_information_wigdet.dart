import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_style.dart';

Widget recipientInformationWidget(
    {required BuildContext context,
    required String name,
    required String phone,
    required String address}) {
  return Dialog(
    shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Text(
          'Thông tin người nhận',
          style: AppStyle.h2,
        ),
      ),
      DataTable(headingRowHeight: 0, columns: [
        DataColumn(
          label: Expanded(child: Container()),
        ),
        DataColumn(
          label: Expanded(child: Container()),
        ),
      ], rows: [
        DataRow(cells: [
          DataCell(Text(
            'Họ và tên',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            name,
            style: AppStyle.h2,
          )),
        ]),
        DataRow(cells: [
          DataCell(Text(
            'Số điện thoại',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            '+$phone',
            style: AppStyle.h2,
          )),
        ]),
        DataRow(cells: [
          DataCell(Text(
            'Địa chỉ',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            address,
            style: AppStyle.h2,
          )),
        ]),
      ]),
      const SizedBox(
        height: 8.0,
      ),
      SizedBox(
        height: 54,
        width: 200,
        child: ElevatedButton(
          onPressed: () => context.pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppStyle.appColor),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
          ),
          child: Text(
            'Thoát',
            style: AppStyle.buttom,
          ),
        ),
      ),
      const SizedBox(
        height: 8.0,
      ),
    ]),
  );
}
