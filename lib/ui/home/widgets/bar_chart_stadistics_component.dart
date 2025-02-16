import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';

// Grafico de estaditicas semanales (Usuarios Registrados y Viajes Realizados)
class BarChartStadisticsComponent extends StatefulWidget {
  const BarChartStadisticsComponent({super.key, required this.isUsers});

  final bool isUsers;

  final Color barBackgroundColor = Colors.grey;
  final Color barColor = const Color(0xFFA0D7E7);
  final Color touchedBarColor = const Color(0xFFCFC8FF);

  @override
  State<StatefulWidget> createState() => BarChartStadisticsComponentState();
}

class BarChartStadisticsComponentState
    extends State<BarChartStadisticsComponent> {
  late GeneralCubit _cubit;

  int touchedIndex = -1;

  @override
  void initState() {
    _cubit = context.read<GeneralCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BarChart(mainBarData()),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 36,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          //borderSide: isTouched
          //    ? BorderSide(color: Colors.amber)
          //    : const BorderSide(color: Colors.red, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: false,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    return List.generate(
      _cubit.state.weeklyStadistics?.length ?? 0,
      (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                i,
                (widget.isUsers == true)
                    ? (_cubit.state.weeklyStadistics?[i].users?.toDouble() ?? 0)
                    : (_cubit.state.weeklyStadistics?[i].trips?.toDouble() ??
                        0),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                i,
                (widget.isUsers == true)
                    ? (_cubit.state.weeklyStadistics?[i].users?.toDouble() ?? 0)
                    : (_cubit.state.weeklyStadistics?[i].trips?.toDouble() ??
                        0),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                i,
                (widget.isUsers == true)
                    ? (_cubit.state.weeklyStadistics?[i].users?.toDouble() ?? 0)
                    : (_cubit.state.weeklyStadistics?[i].trips?.toDouble() ??
                        0),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                i,
                (widget.isUsers == true)
                    ? (_cubit.state.weeklyStadistics?[i].users?.toDouble() ?? 0)
                    : (_cubit.state.weeklyStadistics?[i].trips?.toDouble() ??
                        0),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                i,
                (widget.isUsers == true)
                    ? (_cubit.state.weeklyStadistics?[i].users?.toDouble() ?? 0)
                    : (_cubit.state.weeklyStadistics?[i].trips?.toDouble() ??
                        0),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                i,
                (widget.isUsers == true)
                    ? (_cubit.state.weeklyStadistics?[i].users?.toDouble() ?? 0)
                    : (_cubit.state.weeklyStadistics?[i].trips?.toDouble() ??
                        0),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(
                i,
                (widget.isUsers == true)
                    ? (_cubit.state.weeklyStadistics?[i].users?.toDouble() ?? 0)
                    : (_cubit.state.weeklyStadistics?[i].trips?.toDouble() ??
                        0),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      },
    );

    //List.generate(7, (i) {
    //    switch (i) {
    //      case 0:
    //        return makeGroupData(0, 5, isTouched: i == touchedIndex);
    //      case 1:
    //        return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
    //      case 2:
    //        return makeGroupData(2, 5, isTouched: i == touchedIndex);
    //      case 3:
    //        return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
    //      case 4:
    //        return makeGroupData(4, 9, isTouched: i == touchedIndex);
    //      case 5:
    //        return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
    //      case 6:
    //        return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
    //      default:
    //        return throw Error();
    //    }
    //  });
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            late String day;

            switch (_cubit.state.weeklyStadistics?[group.x].nameDay) {
              case "Saturday":
                day = "Sábado";
              case "Friday":
                day = "Viernes";
              case "Thursday":
                day = "Jueves";
              case "Wednesday":
                day = "Miercoles";
              case "Tuesday":
                day = "Martes";
              case "Monday":
                day = "Lunes";
              case "Sunday":
                day = "Domingo";
              default:
                day = "N/A";
            }
            return BarTooltipItem(
              '$day\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
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
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    late String day;

    switch (_cubit.state.weeklyStadistics?[value.toInt()].nameDay) {
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

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: 16,
      child: Text(
        day,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  /*BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: Colors.blue,
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: Colors.amber,
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: Colors.green,
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: Colors.blue,
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: Colors.blue,
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor: Colors.blue,
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor: Colors.blue,
            );
          default:
            return throw Error();
        }
      }),
      gridData: const FlGridData(show: false),
    );
  }*/
}
