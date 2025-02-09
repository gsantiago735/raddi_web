import 'package:flutter/material.dart';
import 'package:raddi_web/ui/home/widgets/bar_chart_stadistics_component.dart';

class WeeklyStadisticComponent extends StatelessWidget {
  const WeeklyStadisticComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Estadística Semanal",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF11142D),
          ),
        ),
        const SizedBox(height: 30),
        _Component(
          title: "Usuarios registrados",
          value: "40",
          percentage: "21.95%",
        ),
        Divider(height: 60),
        _Component(
          title: "Viajes Realizados",
          value: "246",
          percentage: "11.45%",
        ),
      ],
    );
  }
}

class _Component extends StatelessWidget {
  const _Component(
      {required this.title, required this.value, required this.percentage});

  final String title;
  final String value;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color(0xFF808191), fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF11142D),
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                percentage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7FBA7A),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: SizedBox(height: 200, child: BarChartStadisticsComponent()),
        )
      ],
    );
  }
}
