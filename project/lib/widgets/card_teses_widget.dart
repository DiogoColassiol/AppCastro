import 'package:flutter/material.dart';
import 'package:project/utils/theme_utils.dart';

class CardTeses extends StatefulWidget {
  final String? id;
  final String? desc;
  final String? legenda;
  final bool? isLarge;
  final bool? value;
  final void Function(bool?)? onChanged;

  const CardTeses({
    super.key,
    this.id,
    this.desc,
    this.legenda,
    this.isLarge = false,
    this.value,
    this.onChanged,
  });

  @override
  State<CardTeses> createState() => _CardTesesState();
}

class _CardTesesState extends State<CardTeses> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: ThemeUtils.backgroundColor,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget.isLarge! ? _largeCard(context) : _reducedCard(context),
    );
  }

  Widget _largeCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            _buildCircleId(),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.desc ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ]),
          const SizedBox(height: 15),
          Text(
            widget.legenda ?? '',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _reducedCard(BuildContext context) {
    return CheckboxListTile(
      value: widget.value ?? false,
      onChanged: widget.onChanged,
      activeColor: ThemeUtils.primaryColor,
      title: Row(
        children: [
          _buildCircleIdReduced(),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.desc ?? '',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      subtitle: Text('Requisição: ${widget.legenda ?? ''}'),
    );
  }

  Widget _buildCircleId() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ThemeUtils.primaryColor,
      ),
      alignment: Alignment.center,
      child: Text(
        widget.id ?? '',
        style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildCircleIdReduced() {
    return Container(
      width: 25,
      height: 25,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ThemeUtils.primaryColor,
      ),
      alignment: Alignment.center,
      child: Text(
        widget.id ?? '',
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
