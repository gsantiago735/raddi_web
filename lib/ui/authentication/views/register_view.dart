import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/utils/validators.dart';
import 'package:raddi_web/utils/generic_utils.dart';
import 'package:raddi_web/widgets/input/generic_input.dart';
import 'package:raddi_web/ui/authentication/cubit/cubit.dart';
import 'package:raddi_web/widgets/buttons/generic_button.dart';
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
  late AuthCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState!.validate()) {
      _cubit.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: widget.padding,
        children: [
          Text(
            "Registro",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ConstantColors.cff081131,
            ),
          ),
          const SizedBox(height: 24),
          GenericInput(
            hintText: "Nombre y Apellido",
            prefixIcon: Icons.person,
            textController: _nameController,
            textInputType: TextInputType.name,
            validator: (value) => Validators.fullNameValidation(value),
          ),
          const SizedBox(height: 24),
          GenericInput(
            hintText: "Correo Electrónico",
            prefixIcon: Icons.email,
            textController: _emailController,
            textInputType: TextInputType.emailAddress,
            validator: (value) => Validators.emailValidation(value),
          ),
          const SizedBox(height: 24),
          BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (p, c) => (p.isHiddenPass != c.isHiddenPass),
              builder: (context, state) {
                return GenericInput(
                  obscureText: state.isHiddenPass,
                  hintText: "Contraseña",
                  prefixIcon: Icons.lock_rounded,
                  textController: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () => _cubit.setPasswordVisibility(),
                    icon: Icon((state.isHiddenPass)
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  validator: (value) =>
                      Validators.loginPasswordValidation(value),
                );
              }),
          const SizedBox(height: 24),
          GenericButton(
            text: "Registrarme",
            onTap: () => _submit(),
          ),
        ],
      ),
    );
  }
}
