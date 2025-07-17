import 'package:flutter/material.dart';

class ButtonSec extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? labelColor;
  final String label;

  const ButtonSec({
    super.key,
    this.buttonColor,
    this.labelColor,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(20, 40),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: labelColor,
        ),
      ),
    );
  }
}
