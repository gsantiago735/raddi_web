import 'package:raddi_web/ui/ui.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (_) => const App(),

    // Authentication
    LoginView.routeName: (_) => const LoginView(),
    RegisterView.routeName: (_) => const RegisterView(),
    ForgotPasswordView.routeName: (_) => const ForgotPasswordView(),

    HomeView.routeName: (_) => const HomeView(),
  };
}
