import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartTripsComponent extends StatefulWidget {
  BarChartTripsComponent({super.key});

  final Color leftBarColor = Color(0xFF6C5DD3);
  final Color rightBarColor = Color(0xFFA0D7E7);
  final Color avgColor = Colors.green;

  @override
  State<StatefulWidget> createState() => BarChartTripsComponentState();
}

class BarChartTripsComponentState extends State<BarChartTripsComponent> {
  final double barWidth = 10;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

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
                maxY: 20,
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
                borderData: FlBorderData(
                  show: false,
                ),
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
    } else if (value == 10) {
      text = '50';
    } else if (value == 19) {
      text = '100';
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
    final titles = <String>['Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa', 'Do'];

    final Widget text = Text(
      titles[value.toInt()],
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
