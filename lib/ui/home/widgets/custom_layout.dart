import 'package:flutter/material.dart';

class CustomLayout extends StatelessWidget {
  const CustomLayout({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.fromBorderSide(
            BorderSide(width: 1, color: Color(0xFFE4E4E4))),
      ),
      child: child,
    );
  }
}
