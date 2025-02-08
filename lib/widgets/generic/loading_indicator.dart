import 'package:flutter/material.dart';
import 'package:raddi_web/core/constants/constants_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator(
      {super.key, this.value, this.color = ConstantColors.cff2772F0});

  final double? value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      strokeWidth: 4,
      color: color,
      //backgroundColor: Colors.yellow,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
