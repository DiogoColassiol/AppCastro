import 'package:flutter/material.dart';
import 'package:project/utils/theme_utils.dart';

class CardSegDoc extends StatelessWidget {
  final String nome;
  final bool selecionado;
  final ValueChanged<bool?> onChanged;
  final Key keyTile;

  const CardSegDoc({
    super.key,
    required this.nome,
    required this.selecionado,
    required this.onChanged,
    required this.keyTile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      color: ThemeUtils.backgroundColor,
      child: CheckboxListTile(
        key: keyTile,
        title: Text(
          nome,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        value: selecionado,
        activeColor: ThemeUtils.primaryColor,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
