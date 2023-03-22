import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsp23se37_supplier/src/cubit/store_reveneu/store_reveneu_cubit.dart';
import 'package:gsp23se37_supplier/src/model/reveneu.dart';
import 'package:gsp23se37_supplier/src/utils/app_style.dart';
import 'package:gsp23se37_supplier/src/widget/bloc_load_failed.dart';

class CustomerBarChart extends StatefulWidget {
  const CustomerBarChart(
      {super.key, required this.token, required this.storeID});
  final String token;
  final int storeID;
  @override
  State<CustomerBarChart> createState() => _CustomerBarChartState();
}

class _CustomerBarChartState extends State<CustomerBarChart> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoreReveneuCubit()
        ..loadReveneu(token: widget.token, storeID: widget.storeID, time: 2023),
      child: BlocBuilder<StoreReveneuCubit, StoreReveneuState>(
        builder: (context, state) {
          if (state is StoreReveneuLoaded) {
            return LayoutBuilder(builder: (context, size) {
              return BarChart(
                BarChartData(
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: borderData,
                  barGroups: List.generate(state.list.length, (index) {
                    Reveneu reveneu = state.list[index];
                    return BarChartGroupData(
                      x: reveneu.time,
                      barRods: [
                        BarChartRodData(
                          toY: reveneu.amount,
                          gradient: _barsGradient,
                        )
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }),
                  gridData: FlGridData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 200000,
                ),
              );
            });
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
            return const CircularProgressIndicator();
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
              rod.toY.round().toString(),
              TextStyle(
                color: AppStyle.appColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      // color: V,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(value.toString(), style: style),
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
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Color(0xFF0d47a1),
          Color(0xFFe0f7fa),
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
