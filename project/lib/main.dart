import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/screens/mainScreen.dart';

import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMinSize(const Size(820, 820));
  setWindowMaxSize(const Size(1920, 1080));
  setWindowFrame(const Rect.fromLTWH(100, 100, 820, 820));
  WidgetsFlutterBinding.ensureInitialized();
  // await TeseDataBase.initialize();
  // await SegmentoDataBase.initialize();
  // await RegimeDataBase.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final segmentosDb = Provider.of<SegmentoDataBase>(context, listen: false);
    // final regimesDb = Provider.of<RegimeDataBase>(context, listen: false);
    // final tesesDb = Provider.of<TeseDataBase>(context, listen: false);

    return BlocProvider(
      create: (context) => ProjectCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
