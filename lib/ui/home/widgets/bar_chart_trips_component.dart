import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';

// Grafico de viajes segun el tipo de vehiculo (Carro/Moto)
class BarChartTripsComponent extends StatefulWidget {
  BarChartTripsComponent({super.key});

  final Color leftBarColor = Color(0xFF6C5DD3);
  final Color rightBarColor = Color(0xFFA0D7E7);
  final Color avgColor = Colors.green;

  @override
  State<StatefulWidget> createState() => BarChartTripsComponentState();
}

class BarChartTripsComponentState extends State<BarChartTripsComponent> {
  late GeneralCubit _cubit;

  final double barWidth = 10;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<GeneralCubit>();

    final List<BarChartGroupData> items = [];

    // Recorriendo la lista
    // Agregando un componente de tabla por cada dia de la lista [items]
    for (var i = 0; i < (_cubit.state.tripsOfWeek?.length ?? 0); i++) {
      items.add(
        makeGroupData(
          i,
          (_cubit.state.tripsOfWeek?[i].cars?.toDouble() ?? 0),
          (_cubit.state.tripsOfWeek?[i].bikes?.toDouble() ?? 0),
        ),
      );
    }

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Viajes (Carro/Moto)",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF11142D)),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: 80,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: ((group) {
                      return Colors.grey;
                    }),
                    getTooltipItem: (a, b, c, d) => null,
                  ),
                  touchCallback: (FlTouchEvent event, response) {
                    if (response == null || response.spot == null) {
                      setState(() {
                        touchedGroupIndex = -1;
                        showingBarGroups = List.of(rawBarGroups);
                      });
                      return;
                    }

                    touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                    setState(() {
                      if (!event.isInterestedForInteractions) {
                        touchedGroupIndex = -1;
                        showingBarGroups = List.of(rawBarGroups);
                        return;
                      }
                      showingBarGroups = List.of(rawBarGroups);
                      if (touchedGroupIndex != -1) {
                        var sum = 0.0;
                        for (final rod
                            in showingBarGroups[touchedGroupIndex].barRods) {
                          sum += rod.toY;
                        }
                        final avg = sum /
                            showingBarGroups[touchedGroupIndex].barRods.length;

                        showingBarGroups[touchedGroupIndex] =
                            showingBarGroups[touchedGroupIndex].copyWith(
                          barRods: showingBarGroups[touchedGroupIndex]
                              .barRods
                              .map((rod) {
                            return rod.copyWith(
                                toY: avg, color: widget.avgColor);
                          }).toList(),
                        );
                      }
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 1,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: showingBarGroups,
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    String text;

    if (value == 0) {
      text = '1';
    } else if (value == 40) {
      text = '40';
    } else if (value == 80) {
      text = '80';
    } else {
      return Container();
    }
    return SideTitleWidget(
      space: 0,
      axisSide: AxisSide.bottom,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    late String day;

    switch (_cubit.state.tripsOfWeek?[value.toInt()].nameDay) {
      case "Saturday":
        day = "Sa";
      case "Friday":
        day = "Vi";
      case "Thursday":
        day = "Ju";
      case "Wednesday":
        day = "Mi";
      case "Tuesday":
        day = "Ma";
      case "Monday":
        day = "Lu";
      case "Sunday":
        day = "Do";
      default:
        day = "N/A";
    }

    final Widget text = Text(
      day,
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(space: 16, axisSide: AxisSide.bottom, child: text);
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          borderRadius: BorderRadius.circular(0),
          color: widget.leftBarColor,
          width: barWidth,
        ),
        BarChartRodData(
          toY: y2,
          borderRadius: BorderRadius.circular(0),
          color: widget.rightBarColor,
          width: barWidth,
        ),
      ],
    );
  }
}
