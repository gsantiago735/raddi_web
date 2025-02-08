import 'package:flutter/material.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/core/routes/routes.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await LocalStorage.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GeneralCubit>(create: (_) => GeneralCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raddi Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routes: AppRouter.routes,
    );
  }
}
