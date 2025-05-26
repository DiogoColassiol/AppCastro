import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final double heightButton;
  final double widthButton;
  final Color? color;
  final Color? textColor;

  const ButtonApp({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.color,
    this.textColor,
    this.heightButton = 50,
    this.widthButton = 160,
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
        minimumSize: Size(widthButton, heightButton),
        backgroundColor: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
