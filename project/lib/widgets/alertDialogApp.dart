// ignore: file_names
import 'package:flutter/material.dart';
import 'package:project/utils/theme_utils.dart';

class AlertDialogApp extends StatelessWidget {
  final String title;
  final String content;

  const AlertDialogApp({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: ThemeUtils.backgroundColor,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(content, style: const TextStyle()),
      actions: [_buttonSair(context)],
    );
  }

  _buttonSair(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(20, 40),
        backgroundColor: ThemeUtils.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text('Sair',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
    );
  }
}
