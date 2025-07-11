import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/database/database_cubit.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/database/db.dart';
import 'package:project/repositories/regimeRepo.dart';

import 'package:project/repositories/segmentoRepo.dart';
import 'package:project/screens/mainScreen.dart';
import 'package:project/screens/resultScreen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await DB.instance.database;
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
    return MultiProvider(
      providers: buildAppProviders(),
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

  List<SingleChildWidget> buildAppProviders() {
    return [
      ChangeNotifierProvider(create: (context) => SegmentoDAO()),
      ChangeNotifierProvider(create: (context) => RegimeDAO()),
      BlocProvider(
          create: (context) => DbCubit(regimeDAO: context.read<RegimeDAO>())),
      BlocProvider(
        create: (context) => ProjectCubit(),
      ),
    ];
  }
}
