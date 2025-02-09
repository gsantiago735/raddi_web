import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:raddi_web/ui/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raddi_web/core/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyC81LDasjfwsrRCoRbD4JhEmnlgLT7YPIg",
        authDomain: "raddi-web-test.firebaseapp.com",
        projectId: "raddi-web-test",
        storageBucket: "raddi-web-test.firebasestorage.app",
        messagingSenderId: "310890261160",
        appId: "1:310890261160:web:ee963e2d6ca394e82fb09d"),
  );

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
