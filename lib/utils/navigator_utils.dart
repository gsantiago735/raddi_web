import 'package:flutter/material.dart';

class NavigatorUtils {
  /// Redirecciona al inicio del stack de navegacion
  static void popUntilInitialRoute(BuildContext context) {
    Navigator.of(context).popUntil((route) {
      switch (route.settings.name) {
        case "/":
          return true;
        // case LoginView.routeName:
        //   return true;
        // case HomeView.routeName:
        //   return true;
        // case ErrorHomeView.routeName:
        //   return true;
        default:
          return false;
      }
    });
  }

  /// Resetea los cubits generales, cierra sesión y redirecciona al Login
  static Future<void> resetSession(BuildContext context,
      {bool needsLogOut = true}) async {
    //final genericCubit = context.read<GeneralCubit>();

    //if (needsLogOut) {
    //  await genericCubit.logOut();
    //}

    // await LocalStorage.deleteSession().then((_) {
    //   genericCubit.clean();
    //   Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
    // });
  }
}
