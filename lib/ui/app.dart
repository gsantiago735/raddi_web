import 'package:flutter/material.dart';
import 'package:raddi_web/ui/authentication/views/login_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginView();
    //switch (status) {
    //  // case AppState.onboarding:
    //  //   return const OnboardingView();
    //  case AppState.loggedUser:
    //    return const HomeView();
    //  case AppState.logOut:
    //    return const LoginView();
    //  case AppState.error:
    //    return const ErrorHomeView();
    //}
  }
}
