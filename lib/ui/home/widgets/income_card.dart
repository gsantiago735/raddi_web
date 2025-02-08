import 'package:flutter/material.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Ingresos",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF11142D)),
        ),
        const SizedBox(height: 18),
        BlocBuilder<GeneralCubit, GeneralState>(
            buildWhen: (p, c) => (p.isGross != c.isGross),
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TypeComponent(
                    title: "Bruto",
                    isSelected: state.isGross,
                    onPressed: () =>
                        context.read<GeneralCubit>().setGross(true),
                  ),
                  _TypeComponent(
                    title: "Neto",
                    isSelected: !state.isGross,
                    onPressed: () =>
                        context.read<GeneralCubit>().setGross(false),
                  ),
                ],
              );
            }),
        const SizedBox(height: 8),
        BlocBuilder<GeneralCubit, GeneralState>(
            buildWhen: (p, c) =>
                (p.isGross != c.isGross || p.period != c.period),
            builder: (context, state) {
              return Text(
                "\$${context.read<GeneralCubit>().showIncome()}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 64,
                  color: Color(0xFF6C5DD3),
                  fontWeight: FontWeight.w600,
                ),
              );
            }),
        const SizedBox(height: 8),
        BlocBuilder<GeneralCubit, GeneralState>(
            buildWhen: (p, c) => (p.period != c.period),
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TypeComponent(
                    title: "Día",
                    isSelected: state.period == 0,
                    isPeriod: true,
                    onPressed: () => context.read<GeneralCubit>().setPeriod(0),
                  ),
                  _TypeComponent(
                    title: "Semana",
                    isSelected: state.period == 1,
                    isPeriod: true,
                    onPressed: () => context.read<GeneralCubit>().setPeriod(1),
                  ),
                  _TypeComponent(
                    title: "Mes",
                    isSelected: state.period == 2,
                    isPeriod: true,
                    onPressed: () => context.read<GeneralCubit>().setPeriod(2),
                  ),
                ],
              );
            })
      ],
    );
  }
}

class _TypeComponent extends StatelessWidget {
  const _TypeComponent(
      {required this.title,
      required this.isSelected,
      this.isPeriod = false,
      required this.onPressed});

  final String title;
  final bool isSelected;
  final bool isPeriod;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        constraints: (isPeriod) ? null : BoxConstraints(minWidth: 80),
        padding: (isPeriod)
            ? const EdgeInsets.symmetric(vertical: 18, horizontal: 24)
            : const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: (isSelected) ? Color(0xFF6C5DD3) : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          border: Border.fromBorderSide(BorderSide(color: Color(0xFFDCDCDC))),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: (isSelected) ? Colors.white : Color(0xFF5F75EE),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
