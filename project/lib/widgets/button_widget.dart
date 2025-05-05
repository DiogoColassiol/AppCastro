import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  const ButtonApp({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: textColor ?? Colors.white,
      ),
      label: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: textColor ?? Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 50),
        backgroundColor: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
