// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FloatButton {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final Object? heroTag;

  FloatButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
    this.heroTag,
  });
}

class CustomFloatButton extends StatelessWidget {
  final List<FloatButton> buttons;
  final MainAxisAlignment alignment;
  final double spacing;

  const CustomFloatButton({
    super.key,
    required this.buttons,
    this.alignment = MainAxisAlignment.center,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: buttons
          .map(
            (btn) => Padding(
              padding: EdgeInsets.only(
                right: btn != buttons.last ? spacing : 0,
              ),
              child: FloatingActionButton.extended(
                heroTag: btn.heroTag,
                onPressed: btn.onPressed,
                label: Text(btn.label),
                icon: Icon(btn.icon),
                backgroundColor: btn.backgroundColor,
                foregroundColor: btn.foregroundColor,
              ),
            ),
          )
          .toList(),
    );
  }
}
