import 'package:flutter/material.dart';
import 'package:gsp23se37_supplier/src/model/user.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';

Widget userDialog({required BuildContext context, required User user}) {
  return Dialog(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        'Thông tin nhà cung cấp',
        style: AppStyle.h2,
      ),
      SizedBox(
        height: 200,
        width: 200,
        child: Image.network(user.image.path.split('?')[0], fit: BoxFit.cover),
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
          DataCell(Text(
            user.userName,
            style: AppStyle.h2,
          )),
        ]),
        DataRow(cells: [
          DataCell(Text(
            'Ngày sinh',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            user.dateOfBirth.split('T')[0],
            style: AppStyle.h2,
          )),
        ]),
        DataRow(cells: [
          DataCell(Text(
            'Giới tính',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            user.gender,
            style: AppStyle.h2,
          )),
        ]),
        DataRow(cells: [
          DataCell(Text(
            'Email',
            style: AppStyle.h2,
          )),
          DataCell(Text(
            user.email,
            style: AppStyle.h2,
          )),
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
          DataCell(Text(
            user.addresses[0].addressString(),
            style: AppStyle.h2,
            maxLines: 1,
            overflow: TextOverflow.fade,
          )),
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
  );
}
