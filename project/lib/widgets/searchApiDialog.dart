// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/utils/theme_utils.dart';

class SearchApiDialog extends StatelessWidget {
  final ReceitaModel receita;
  const SearchApiDialog({super.key, required this.receita});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: ThemeUtils.backgroundColor,
      title: const Text(
        'Dados retornados da Api',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: _buildContent(context),
      actions: [_buttonSair(context), _buttonAdd(context)],
    );
  }

  _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [Text("Razao social: ${receita.nome}")],
        ),
        Row(
          children: [Text("Nome Fantasia: ${receita.fantasia}")],
        ),
        Row(
          children: [Text("Data de Abertura: ${receita.abertura}")],
        ),
        Row(
          children: [Text("Situação: ${receita.situacao}")],
        ),
      ],
    );
  }

  _buttonSair(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final c = context.read<ProjectCubit>();
        return ElevatedButton(
          onPressed: () {
            c.setHasApi(false);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(20, 40),
            backgroundColor: Colors.red[400],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Sair',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white)),
        );
      },
    );
  }

  _buttonAdd(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final c = context.read<ProjectCubit>();
        return ElevatedButton(
          onPressed: () async {
            await c.setHasApi(true);
            await c.setReturnApi(receita);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(20, 40),
            backgroundColor: ThemeUtils.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Adicionar ao Relatório',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white)),
        );
      },
    );
  }
}
