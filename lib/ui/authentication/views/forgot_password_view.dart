import 'package:flutter/material.dart';
import 'package:raddi_web/utils/validators.dart';
import 'package:raddi_web/utils/generic_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/models/generic/generic.dart';
import 'package:raddi_web/widgets/generic/generic.dart';
import 'package:raddi_web/widgets/input/generic_input.dart';
import 'package:raddi_web/ui/authentication/cubit/cubit.dart';
import 'package:raddi_web/widgets/buttons/generic_button.dart';
import 'package:raddi_web/core/constants/constants_colors.dart';
import 'package:raddi_web/widgets/dialogs/generic_status_dialog.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static const String routeName = 'forgot_password_view';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(),
      child: Scaffold(
          body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (p, c) => (p.genericStatus != c.genericStatus),
        listener: (context, state) {
          switch (state.genericStatus) {
            case WidgetStatus.loading:
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (context) => PopScope(
                  canPop: false,
                  child: Center(child: LoadingIndicator()),
                ),
              );
              break;

            case WidgetStatus.error:
              Navigator.pop(context);
              showDialog<void>(
                context: context,
                builder: (_) => GenericStatusDialog(
                    //exception: state.exception,
                    ),
              );
              break;

            case WidgetStatus.success:
              Navigator.pop(context);
              break;
            default:
              break;
          }
        },
        child: SafeArea(
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
  late AuthCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: ListView(
        padding: widget.padding,
        children: [
          Placeholder(fallbackHeight: size.height * 0.25),
          const SizedBox(height: 48),
          Text(
            "Recuperar Contraseña",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              color: ConstantColors.cff081131,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Introduce tu correo electrónico para obtener el link de recuperación",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: ConstantColors.cff6978A0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 48),
          GenericInput(
            hintText: "Correo Electrónico",
            prefixIcon: Icons.email,
            textController: _emailController,
            textInputType: TextInputType.emailAddress,
            validator: (value) => Validators.emailValidation(value),
          ),
          const SizedBox(height: 32),
          GenericButton(
            text: "Recuperar Contraseña",
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();

              if (_formKey.currentState!.validate()) {
                _cubit.forgotPassword();
              }
            },
          ),
        ],
      ),
    );
  }
}
