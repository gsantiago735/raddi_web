import 'package:flutter/material.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Métodos de Pago",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF11142D),
          ),
        ),
        const SizedBox(height: 16),
        BlocBuilder<GeneralCubit, GeneralState>(
            buildWhen: (p, c) => (p.payment != c.payment),
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: state.payment?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _Option(
                    title: state.payment?[index].typePayment?.getText ?? "N/A",
                    value: ((state.payment?[index].percentagUsed ?? 0))
                        .toStringAsFixed(2),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 40),
              );
            }),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF6C5DD3),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Icon(
          Icons.wallet_rounded,
          color: Colors.white,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right_rounded,
        color: Color(0xFF11142D),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF11142D),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "$value% de las veces.",
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF808191),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
