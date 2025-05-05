import 'package:flutter/material.dart';
import 'package:project/utils/theme_utils.dart';

class CardTeses extends StatefulWidget {
  final String? id;
  final String? desc;
  final String? legenda;
  const CardTeses({
    super.key,
    required this.id,
    required this.desc,
    required this.legenda,
  });

  @override
  State<CardTeses> createState() => _CardTesesState();
}

class _CardTesesState extends State<CardTeses> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeUtils.backgroundColor,
      // elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(widget.desc ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)))
            ]),
            const SizedBox(height: 15),
            Text(
              widget.legenda ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
