import 'package:flutter/material.dart';
import 'package:project/abstract/abstract_route.dart';
import 'package:project/routes/mainScreen_route.dart';
import 'package:project/routes/resultScreen_route.dart';

class AppRoutes {
  static const String home = 'home';
  static const String result = 'result';

  static final Map<String, AbstractRoute Function(BuildContext context)>
      routes = {
    home: (context) => const MainScreenRoute(),
    result: (context) => const ResultScreenRoute(),
  };
}
