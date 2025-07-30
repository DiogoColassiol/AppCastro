// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class Alertbar {
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    IconData icon = Icons.info_outline,
    Color backgroundColor = Colors.black87,
    Duration duration = const Duration(seconds: 3),
    FlushbarPosition position = FlushbarPosition.TOP,
  }) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(icon, color: Colors.white),
      backgroundColor: backgroundColor,
      duration: duration,
      flushbarPosition: position,
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.all(12),
    ).show(context);
  }

  static void showError(BuildContext context, String message) {
    show(
      context,
      message: message,
      title: 'Erro',
      icon: Icons.error_outline,
      backgroundColor: Colors.red,
    );
  }

  static void showWarning(BuildContext context, String message) {
    show(
      context,
      message: message,
      title: 'Atenção',
      icon: Icons.warning_amber,
      backgroundColor: Colors.amber,
    );
  }

  static void showSuccess(BuildContext context, String message) {
    show(
      context,
      message: message,
      title: 'Sucesso',
      icon: Icons.check_circle,
      backgroundColor: Colors.green,
    );
  }
}
