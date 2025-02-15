import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/utils/validators.dart';
import 'package:raddi_web/utils/generic_utils.dart';
import 'package:raddi_web/providers/providers.dart';
import 'package:raddi_web/widgets/generic/generic.dart';
import 'package:raddi_web/ui/home/views/home_view.dart';
import 'package:raddi_web/widgets/input/generic_input.dart';
import 'package:raddi_web/models/generic/generic_enums.dart';
import 'package:raddi_web/ui/authentication/views/views.dart';
import 'package:raddi_web/ui/authentication/cubit/cubit.dart';
import 'package:raddi_web/widgets/buttons/generic_button.dart';
import 'package:raddi_web/core/constants/constants_colors.dart';
import 'package:raddi_web/ui/authentication/widgets/left_side_component.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'login_view';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState!.validate()) {
      _cubit.login(
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
            "Iniciar Sesión",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ConstantColors.cff081131,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Bienvenido de vuelta!",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ConstantColors.cff6978A0,
            ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: _RememberMeComponent(),
              ),
              Flexible(
                  child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgotPasswordView.routeName),
                  child: MouseRegion(
                    cursor: WidgetStateMouseCursor.clickable,
                    child: Text(
                      "¿Olvidaste tu contraseña?",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ConstantColors.cff2772F0,
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
          const SizedBox(height: 24),
          GenericButton(
            text: "Iniciar Sesión",
            onTap: () => _submit(),
          ),
          const SizedBox(height: 12),
          GenericButton(
            text: "Continuar con Google",
            color: Colors.white,
            textColor: Color(0xFF757575),
            borderColor: Color(0xFF757575),
            onTap: () async {
              await AuthLocalProvider().signInWithGoogle().then((value) {
                if (value.additionalUserInfo?.profile?["email"] != null) {
                  if (!context.mounted) return;
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      HomeView.routeName, (Route<dynamic> route) => false);
                }
              });
            },
          ),
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
          const _RegisterText(),
        ],
      ),
    );
  }
}

class _RememberMeComponent extends StatelessWidget {
  const _RememberMeComponent();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (p, c) => (p.rememberMe != c.rememberMe),
            builder: (context, state) {
              return Checkbox(
                value: state.rememberMe,
                activeColor: ConstantColors.cff2772F0,
                onChanged: (value) => context.read<AuthCubit>().setRememberMe(),
              );
            }),
        Flexible(
          child: GestureDetector(
            onTap: () => context.read<AuthCubit>().setRememberMe(),
            child: MouseRegion(
              cursor: WidgetStateMouseCursor.clickable,
              child: const Text(
                "Recuérdame",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: ConstantColors.cff8D98AF,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _RegisterText extends StatelessWidget {
  const _RegisterText();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: TextAlign.left,
      TextSpan(
        style: const TextStyle(
          fontSize: 14,
          color: ConstantColors.cff8D98AF,
          fontWeight: FontWeight.w600,
        ),
        children: [
          const TextSpan(text: "¿No tienes cuenta? "),
          TextSpan(
            mouseCursor: WidgetStateMouseCursor.clickable,
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => Navigator.pushNamed(context, RegisterView.routeName),
            text: "Registrate",
            style: const TextStyle(
              fontSize: 14,
              color: ConstantColors.cff2772F0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
