import 'package:flutter/material.dart';
import 'package:raddi_web/utils/generic_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/ui/authentication/cubit/cubit.dart';
import 'package:raddi_web/core/constants/constants_colors.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const String routeName = 'register_view';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(),
      child: Scaffold(
          body: SafeArea(
        child: GenericUtils.isDesktop(context)
            ? Row(
                children: [
                  Expanded(
                    child: Container(
                      color: ConstantColors.cff2772F0,
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.16,
                        horizontal: size.width * 0.08,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Placeholder(color: Colors.white),
                          ),
                          SizedBox(height: size.height * 0.06),
                          const Text(
                            "Cambia tu capital con facilidad y las mejores tasas.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          const Text(
                            '''P2B es el lugar más sencillo para comprar y '''
                            '''vender divisas. Intercambie sus euros, '''
                            '''dólares y USDT en minutos.''',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _Form(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.16,
                        horizontal: size.width * 0.08,
                      ),
                    ),
                  ),
                ],
              )
            : _Form(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.06,
                  horizontal:
                      GenericUtils.isTablet(context) ? size.width * 0.2 : 32,
                ),
              ),
      )),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({required this.padding});

  final EdgeInsets padding;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: widget.padding,
      children: [
        Placeholder(),
      ],
    );
  }
}
