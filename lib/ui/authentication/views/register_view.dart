import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/utils/validators.dart';
import 'package:raddi_web/utils/generic_utils.dart';
import 'package:raddi_web/ui/home/views/home_view.dart';
import 'package:raddi_web/widgets/input/generic_input.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';
import 'package:raddi_web/ui/authentication/cubit/cubit.dart';
import 'package:raddi_web/widgets/buttons/generic_button.dart';
import 'package:raddi_web/core/constants/constants_colors.dart';
import 'package:raddi_web/widgets/generic/loading_indicator.dart';
import 'package:raddi_web/ui/authentication/widgets/left_side_component.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const String routeName = 'register_view';

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
              break;

            case WidgetStatus.success:
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeView.routeName, (Route<dynamic> route) => false);
              break;
            default:
              break;
          }
        },
        child: SafeArea(
          child: GenericUtils.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(child: LeftSideComponent()),
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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpasswordController = TextEditingController();

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
    _cpasswordController.dispose();
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
                  validator: (value) => Validators.registerPasswordValidation(
                      value,
                      _passwordController.text,
                      _cpasswordController.text),
                );
              }),
          const SizedBox(height: 24),
          BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (p, c) => (p.isHiddenCpass != c.isHiddenCpass),
              builder: (context, state) {
                return GenericInput(
                  obscureText: state.isHiddenCpass,
                  hintText: "Confirmar Contraseña",
                  prefixIcon: Icons.lock_rounded,
                  textController: _cpasswordController,
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    onPressed: () => _cubit.setCPasswordVisibility(),
                    icon: Icon((state.isHiddenCpass)
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  validator: (value) => Validators.registerPasswordValidation(
                      value,
                      _passwordController.text,
                      _cpasswordController.text),
                );
              }),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (p, c) => (p.exception != c.exception),
            builder: (context, state) {
              if ((state.exception ?? "").isEmpty) return SizedBox.shrink();
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    state.exception ?? "N/A",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
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
