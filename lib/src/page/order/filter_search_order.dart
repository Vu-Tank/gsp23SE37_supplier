import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gsp23se37_supplier/src/model/order/order_search.dart';
import 'package:intl/intl.dart';

import '../../utils/app_style.dart';
import '../../utils/utils.dart';

class FilterSearchOrder extends StatefulWidget {
  const FilterSearchOrder({super.key, required this.orderSearch});
  final OrderSearch orderSearch;
  @override
  State<FilterSearchOrder> createState() => _FilterSearchOrderState();
}

class _FilterSearchOrderState extends State<FilterSearchOrder> {
  DateTime? dateFrom;
  DateTime? dateTo;
  late OrderSearch _orderSearch;
  @override
  void initState() {
    super.initState();
    _orderSearch = widget.orderSearch;
    if (_orderSearch.dateFrom != null) {
      dateFrom = DateFormat("MM/dd/yyyy").parse(_orderSearch.dateFrom!);
    }
    if (_orderSearch.dateTo != null) {
      dateTo = DateFormat("MM/dd/yyyy").parse(_orderSearch.dateTo!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        'Lọc',
        style: AppStyle.h2,
      ),
      DataTable(headingRowHeight: 0, columns: [
        DataColumn(label: Container()),
        DataColumn(label: Container()),
      ], rows: [
        DataRow(cells: [
          DataCell(TextButton(
              // onPressed: () => DatePicker.showDatePicker(context,
              //         showTitleActions: true,
              //         minTime: DateTime(2018, 3, 5),
              //         maxTime: DateTime.now(), onChanged: (date) {
              //       // log('change $date');
              //     }, onConfirm: (date) {
              //       setState(() => dateFrom = date);
              //       _orderSearch.dateTo = Utils.convertDateTimeToString(date);
              //       _orderSearch.page = 1;
              //     }, currentTime: DateTime.now(), locale: LocaleType.vi),
              onPressed: () async {
                DateTime? dateTime = await showDatePicker(
                  context: context,
                  locale: const Locale("vi", "VN"),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime.now(),
                );
                if (dateTime != null) {
                  setState(() {
                    dateFrom = dateTime;
                  });
                  _orderSearch.dateFrom =
                      Utils.convertDateTimeToString(dateTime);
                  _orderSearch.page = 1;
                }
              },
              child: Text(
                'Từ ngày',
                style: AppStyle.h2.copyWith(color: Colors.blue),
              ))),
          DataCell(Text(
            (dateFrom != null) ? Utils.convertDateTimeToString(dateFrom!) : '',
            style: AppStyle.h2,
          ))
        ]),
        DataRow(cells: [
          DataCell(TextButton(
              // onPressed: () => DatePicker.showDatePicker(context,
              //         showTitleActions: true,
              //         minTime: dateFrom ?? DateTime(2018, 3, 5),
              //         maxTime: DateTime.now(), onChanged: (date) {
              //       // log('change $date');
              //     }, onConfirm: (date) {
              //       setState(() => dateTo = date);
              //       _orderSearch.dateTo = Utils.convertDateTimeToString(date);
              //       _orderSearch.page = 1;
              //     }, currentTime: DateTime.now(), locale: LocaleType.vi),
              onPressed: () async {
                DateTime? dateTime = await showDatePicker(
                  context: context,
                  locale: const Locale("vi", "VN"),
                  initialDate: DateTime.now(),
                  firstDate: (dateFrom != null) ? dateFrom! : DateTime(2018),
                  lastDate: DateTime.now(),
                );
                if (dateTime != null) {
                  setState(() {
                    dateTo = dateTime;
                    _orderSearch.dateTo =
                        Utils.convertDateTimeToString(dateTime);
                    _orderSearch.page = 1;
                  });
                }
              },
              child: Text(
                'Đến ngày',
                style: AppStyle.h2.copyWith(color: Colors.blue),
              ))),
          DataCell(Text(
            (dateTo != null) ? Utils.convertDateTimeToString(dateTo!) : '',
            style: AppStyle.h2,
          ))
        ]),
        DataRow(cells: [
          DataCell(
            Text(
              'Thiết lập lại',
              style: AppStyle.h2.copyWith(color: Colors.blue),
            ),
            onTap: () => context.pop(OrderSearch(
                storeID: _orderSearch.storeID,
                page: _orderSearch.page,
                shipOrderStatus: _orderSearch.shipOrderStatus,
                orderID: _orderSearch.orderID,
                userName: _orderSearch.userName)),
          ),
          DataCell(
            Text(
              'Tìm',
              style: AppStyle.h2.copyWith(color: Colors.blue),
            ),
            onTap: () => context.pop(_orderSearch),
          )
        ])
      ])
    ]);
  }
}
