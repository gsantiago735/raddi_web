import 'package:flutter/material.dart';
import 'package:raddi_web/core/constants/constants_colors.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onTap;

  const GenericButton({
    super.key,
    required this.text,
    this.color = ConstantColors.cff2772F0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, 60)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              side: BorderSide(
                width: 1,
                color: (onTap != null)
                    ? ConstantColors.cff2772F0
                    : Colors.transparent,
              ),
            ),
          ),
          backgroundColor:
              (onTap != null) ? WidgetStatePropertyAll(color) : null,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: (onTap != null) ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
