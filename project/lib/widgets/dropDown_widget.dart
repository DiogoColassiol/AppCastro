import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final Widget Function(T)? itemIcon;
  final ValueChanged<T?> onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemLabel,
    this.itemIcon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      dropdownColor: Colors.white,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Row(
            children: [
              if (itemIcon != null) ...[
                itemIcon!(item),
                const SizedBox(width: 5),
              ],
              Text(itemLabel(item)),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
