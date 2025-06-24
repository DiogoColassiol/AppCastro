import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/screens/mainScreen.dart';
import 'package:project/screens/resultScreen.dart';

import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMinSize(const Size(820, 820));
  setWindowMaxSize(const Size(1920, 1080));
  setWindowFrame(const Rect.fromLTWH(100, 100, 820, 820));
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => const MainScreen(),
          'result': (context) => const ResultScreen(),
        },
      ),
    );
  }
}
