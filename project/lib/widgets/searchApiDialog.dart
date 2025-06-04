// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/utils/theme_utils.dart';

class SearchApiDialog extends StatefulWidget {
  const SearchApiDialog({super.key});

  @override
  State<SearchApiDialog> createState() => _SearchApiDialogState();
}

class _SearchApiDialogState extends State<SearchApiDialog> {
  late ReceitaModel? receitaReturn;

  @override
  void initState() {
    receitaReturn = null;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: ThemeUtils.backgroundColor,
          title: const Text(
            'Consulta de dados API',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: _buildContent(context),
          actions: [
            _buttonSair(context),
            if (receitaReturn == null) _buttonSearch(context),
            if (receitaReturn != null) _buttonAdd(context)
          ],
        );
      },
    );
  }

  _buildContent(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final receita = receitaReturn;
        return receita != null
            ? _resultSearchContent(context)
            : _selectDadosContent(context);
      },
    );
  }

  _resultSearchContent(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final receita = receitaReturn!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [Text("Razão Social: ${receita.nome}")],
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
      },
    );
  }

  _selectDadosContent(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Text(
          'CNPJ: ${state.cliente}',
        );
      },
    );
  }

  _buttonSair(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final c = context.read<ProjectCubit>();
        return ElevatedButton(
          onPressed: () {
            c.setHasApi(false);
            c.setReturnApi(null);
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
            await c.setReturnApi(receitaReturn);
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

  _buttonSearch(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final c = context.read<ProjectCubit>();
        return ElevatedButton(
          onPressed: () async {
            final receita = await c.getDadosClient();
            if (receita != null) {
              setState(() {
                receitaReturn = receita;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(20, 40),
            backgroundColor: ThemeUtils.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Buscar dados',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white)),
        );
      },
    );
  }
}
