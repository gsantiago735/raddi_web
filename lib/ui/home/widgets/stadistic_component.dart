import 'package:flutter/material.dart';
import 'package:raddi_web/ui/home/widgets/custom_layout.dart';

class StadisticComponent extends StatelessWidget {
  const StadisticComponent(
      {super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFF6C5DD3),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: Icon(
                  Icons.folder_rounded,
                  color: Colors.white,
                  size: 12,
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF808191),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 40,
              color: Color(0xFF11142D),
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
