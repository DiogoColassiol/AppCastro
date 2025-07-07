// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/utils/theme_utils.dart';

class CardApiInfos extends StatelessWidget {
  final ReceitaModel? receita;

  const CardApiInfos({
    super.key,
    required this.receita,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: ThemeUtils.backgroundColor,
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
                  _infoRow(
                      Icons.store, "Nome Fantasia", '${receita!.fantasia}'),
                  _infoRow(Icons.date_range, "Data de Abertura",
                      '${receita!.abertura}'),
                  _infoRow(
                      Icons.info_outline, "Situação", '${receita!.situacao}'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buttonDelete(BuildContext context) {
  //   return BlocBuilder<ProjectCubit, ProjectState>(
  //     builder: (context, state) {
  //       final c = context.read<ProjectCubit>();
  //       return ButtonApp(
  //         onPressed: () async {
  //           await c.clearApiResult();
  //         },
  //         text: 'Remover',
  //         textColor: Colors.red,
  //         color: Colors.white,
  //         icon: Icons.delete,
  //       );
  //     },
  //   );
  // }

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
