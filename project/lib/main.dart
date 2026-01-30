import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/database/firedb.dart';
import 'package:project/screens/mainScreen.dart';
import 'package:project/screens/resultScreen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'firebase_options.dart';

import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMinSize(const Size(414, 896));
  setWindowMaxSize(const Size(1920, 1080));
  setWindowFrame(const Rect.fromLTWH(100, 100, 820, 820));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirestoreDB.instance.initialize();

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
      BlocProvider(create: (context) => ProjectCubit(FirestoreDB.instance)),
    ];
  }
}
