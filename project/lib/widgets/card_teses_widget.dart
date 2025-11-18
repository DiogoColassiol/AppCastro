import 'package:flutter/material.dart';
import 'package:project/entity/tesess.dart';
import 'package:project/utils/theme_utils.dart';

class CardTeses extends StatefulWidget {
  final Tese? tese;
  final bool? isLarge;
  final bool? onlyRead;
  final bool? value;
  final void Function(bool?)? onChanged;

  const CardTeses({
    super.key,
    this.tese,
    this.isLarge = false,
    this.onlyRead = false,
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
      color: Colors.white,
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
          Row(
            children: [
              _buildCircleId(),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${widget.tese!.descricao}.',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // const Row(
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(left: 60),
          //       child: Text(
          //         '(Administrativa)',
          //         style: TextStyle(fontSize: 14, color: Colors.black54),
          //       ),
          //     ),
          //   ],
          // ),
          //      const SizedBox(height: 15),
          // Text(
          //   'Documentação: ${widget.tese!.documentos}',
          //   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 15),
          Text(
            widget.tese!.legenda ?? '',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _reducedCard(BuildContext context) {
    if (widget.onlyRead == true) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCircleIdReduced(),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tese!.descricao ?? '',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Requisição: ${widget.tese!.docs ?? ''}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
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
              widget.tese!.descricao ?? '',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      subtitle: Text('Requisição: ${widget.tese!.docs ?? ''}'),
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
        widget.tese!.id.toString(),
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
        widget.tese!.id.toString(),
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
