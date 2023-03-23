import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/store_reveneu/store_reveneu_cubit.dart';
import 'package:gsp23se37_supplier/src/model/reveneu.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/utils/utils.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';
import 'package:intl/intl.dart';

class CustomerBarChart extends StatefulWidget {
  const CustomerBarChart(
      {super.key, required this.token, required this.storeID});
  final String token;
  final int storeID;
  @override
  State<CustomerBarChart> createState() => _CustomerBarChartState();
}

class _CustomerBarChartState extends State<CustomerBarChart> {
  int? year;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreReveneuCubit()
        ..loadReveneu(
          token: widget.token,
          storeID: widget.storeID,
        ),
      child: BlocBuilder<StoreReveneuCubit, StoreReveneuState>(
        builder: (context, state) {
          if (state is StoreReveneuLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 54,
                  child: DropdownButtonFormField(
                    value: (state.time == null)
                        ? 'Chọn năm'
                        : state.time!.toString(),
                    icon: const Icon(Icons.arrow_downward),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(40)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppStyle.appColor, width: 2),
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    isExpanded: true,
                    elevation: 10,
                    validator: (value) {
                      return null;
                    },
                    style: AppStyle.h2,
                    onChanged: (String? value) {
                      if (value != null) {
                        year = (value != 'Chọn năm') ? int.parse(value) : null;
                        context.read<StoreReveneuCubit>().loadReveneu(
                            token: widget.token,
                            storeID: widget.storeID,
                            time: (value != 'Chọn năm')
                                ? int.parse(value)
                                : null);
                      }
                    },
                    items: Utils.gennerationYearSelect()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppStyle.h2,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                (Utils.checkEmptyListReveneu(state.list))
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'Không có dữ liệu',
                            style: AppStyle.errorStyle,
                          ),
                        ),
                      )
                    : Expanded(
                        child: BarChart(
                          BarChartData(
                            barTouchData: barTouchData,
                            titlesData: titlesData,
                            borderData: borderData,
                            barGroups: List.generate(
                                (year != null && year == DateTime.now().year)
                                    ? DateTime.now().month
                                    : state.list.length, (index) {
                              Reveneu reveneu = state.list[index];
                              return BarChartGroupData(
                                x: reveneu.time,
                                barRods: [
                                  BarChartRodData(
                                    toY: reveneu.amount,
                                    width: 30,
                                    borderRadius:
                                        const BorderRadius.all(Radius.zero),
                                    gradient: _barsGradient,
                                  )
                                ],
                                showingTooltipIndicators: [0],
                              );
                            }),
                            gridData: FlGridData(show: false),
                            alignment: BarChartAlignment.spaceAround,
                            maxY: Utils.findMaxReveneu(state.list) +
                                Utils.findMaxReveneu(state.list) * 0.1,
                          ),
                        ),
                      ),
              ],
            );
          } else if (state is StoreReveneuLoadFailed) {
            return blocLoadFailed(
              msg: state.msg,
              reload: () {
                context
                    .read<StoreReveneuCubit>()
                    .loadReveneu(token: widget.token, storeID: widget.storeID);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0)
                  .format(rod.toY.round()),
              AppStyle.h2,
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    String text = value.toString();
    if (value <= 12) {
      text = 'Tháng $value';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: AppStyle.h2),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color.fromARGB(255, 139, 244, 169),
          Color.fromARGB(255, 8, 154, 37),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 15,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 13,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 10,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 16,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
