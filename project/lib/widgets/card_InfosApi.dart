import 'package:flutter/material.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/widgets/button_widget.dart';

class CardApiInfos extends StatelessWidget {
  final ReceitaModel? receita;

  const CardApiInfos({
    super.key,
    required this.receita,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Dados da API',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _infoRow(Icons.business, "Razão Social", '${receita!.nome}'),
                _infoRow(Icons.store, "Nome Fantasia", '${receita!.fantasia}'),
                _infoRow(Icons.date_range, "Data de Abertura",
                    '${receita!.abertura}'),
                _infoRow(
                    Icons.info_outline, "Situação", '${receita!.situacao}'),
                const SizedBox(height: 20),
                Center(
                  child: ButtonApp(
                    text: 'Excluir dados',
                    textColor: Colors.blue,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 10),
          Text(
            '$label: $value',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
