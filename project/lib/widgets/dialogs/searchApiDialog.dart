// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/cubit/project/project_cubit.dart';
import 'package:project/cubit/project/project_state.dart';
import 'package:project/enum/inputType_enum.dart';
import 'package:project/screens/mainScreen.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/input_widget.dart';

class ApiDialog {
  static Future<void> show(BuildContext context) async {
    final cubit = context.read<ProjectCubit>();
    return await showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<ProjectCubit>.value(
            value: cubit, child: const SearchApiDialog());
      },
    );
  }
}

class SearchApiDialog extends StatefulWidget {
  const SearchApiDialog({super.key});

  @override
  State<SearchApiDialog> createState() => _SearchApiDialogState();
}

class _SearchApiDialogState extends State<SearchApiDialog> {
  late ReceitaModel? receitaReturn;
  late TextEditingController _inputControler;

  @override
  void initState() {
    receitaReturn = null;
    _inputControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputControler.clear();
    _inputControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectCubit, ProjectState>(
        listenWhen: (p, c) => p.apiResult != c.apiResult,
        listener: (context, state) {
          if (state.apiResult!.nome != null) {
            Navigator.pop(context);
          }
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: ThemeUtils.backgroundColor,
          title: const Text(
            'Busca de dados via API',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: _buildContent(context),
          actions: [
            _buttonSair(context),
            if (receitaReturn == null) _buttonSearch(context),
            if (receitaReturn != null) _buttonAdd(context),
          ],
        ));
  }

  _buildContent(BuildContext context) {
    final receita = receitaReturn;
    return receita != null
        ? _resultSearchContent(context)
        : _selectDadosContent(context);
  }

  _resultSearchContent(BuildContext context) {
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
  }

  _selectDadosContent(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'O CNPJ do cliente não deve conter caracteres especiais, apenas números para realizar a busca.',
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Input(
            label: 'Informe o CNPJ',
            inputFormat: InputTypeEnum.numbersOnly,
            maxDigitsLength: 14,
            value: cubit.state.clienteCnpj,
            controller: _inputControler,
            onChanged: (value) {
              cubit.setClienteCnpj(value);
            },
          ),
        ),
      ],
    );
  }

  _buttonAdd(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final c = context.read<ProjectCubit>();
        await c.setReturnApi(receitaReturn);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
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
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
    );
  }

  _buttonSair(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final c = context.read<ProjectCubit>();
        await c.clearApiResult();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(20, 40),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text('Sair',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red)),
    );
  }

  _buttonSearch(BuildContext context) {
    final c = context.read<ProjectCubit>();
    return ElevatedButton(
      onPressed: () async {
        final receita = await c.getDadosClient(context);
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
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
    );
  }
}
