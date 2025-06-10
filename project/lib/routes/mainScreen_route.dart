import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/abstract/abstract_route.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/screens/mainScreen.dart';

class MainScreenRoute extends AbstractRoute {
  const MainScreenRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectCubit(),
      child: const MainScreen(),
    );
  }
}
