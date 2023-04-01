import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/order_ship/order_ship_cubit.dart';
import 'package:gsp23se37_supplier/src/model/order/ship_status_model.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';

Widget shipOrderWidget(
    {required BuildContext context,
    required int? orderID,
    required int? serviceID,
    required String token}) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => OrderShipCubit()
          ..loadOrderShipStatus(
              orderID: orderID, serviceID: serviceID, token: token),
        child: BlocBuilder<OrderShipCubit, OrderShipState>(
          builder: (context, orderShipState) {
            if (orderShipState is OrderShipLoadFailed) {
              return blocLoadFailed(
                msg: orderShipState.msg,
                reload: () {
                  context.read<OrderShipCubit>().loadOrderShipStatus(
                      orderID: orderID, serviceID: serviceID, token: token);
                },
              );
            } else if (orderShipState is OrderShipLoadSuccess) {
              return ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                }),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      'Chi tiến giao hàng',
                      style: AppStyle.h2,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mã vận đơn: ',
                          style: AppStyle.h2,
                        ),
                        GestureDetector(
                          child: Text(
                            orderShipState.orderShipStatus.labelID,
                            style: AppStyle.h2,
                          ),
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(
                                text: orderShipState.orderShipStatus.labelID));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    DataTable(
                        // headingRowHeight: 0,
                        columns: [
                          DataColumn(
                              label: Text(
                            'Thời gian',
                            style: AppStyle.h2,
                          )),
                          DataColumn(
                              label: Text(
                            'Trạng thái',
                            style: AppStyle.h2,
                          )),
                        ],
                        rows: List.generate(
                            orderShipState.orderShipStatus.shipStatusModels
                                .length, (index) {
                          ShipStatusModel shipStatusModel = orderShipState
                              .orderShipStatus.shipStatusModels[index];
                          return DataRow(cells: [
                            DataCell(Text(
                              shipStatusModel.create_Date
                                  .replaceAll('T', ' ')
                                  .split('.')[0],
                              style: AppStyle.h2,
                            )),
                            DataCell(Text(
                              shipStatusModel.status,
                              style: AppStyle.h2,
                            )),
                          ]);
                        })),
                  ]),
                ),
              );
            } else {
              return const SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    ),
  );
}
