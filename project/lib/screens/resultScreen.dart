// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/entity/result.dart';
import 'package:project/screens/mainScreen.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/utils/theme_utils.dart';

class ResultScreen extends StatefulWidget {
  final Result? result;
  const ResultScreen({
    super.key,
    required this.result,
  });

  @override
  State<ResultScreen> createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
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
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: ThemeUtils.backgroundColor,
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.transparent,
            title: Center(
              child: Image.asset(
                'lib/images/logo1.png',
                height: 230,
              ),
            ),
          ),
          body: content(widget.result!),
        );
      },
    );
  }
}

Widget content(Result result) {
  return Column(
    children: [
      Container(
        width: double.maxFinite,
        color: ThemeUtils.backgroundColor,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
            child: Text(
              'Exemplo Visualização do PDF',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          width: double.infinity,
          color: ThemeUtils.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [pdf(result)],
              ),
            ),
          ),
        ),
      ),
      Container(
        color: ThemeUtils.backgroundColor,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buttonDelete(),
            const SizedBox(width: 30),
            _buttonPrint(result)
          ],
        ),
      ),
    ],
  );
}

Widget pdf(Result result) {
  final formatedData = DateFormat('dd/MM/yyyy').format(result.dataDoc!);
  final formatedHora = DateFormat('HH:mm').format(result.dataDoc!);

  return Center(
    child: Container(
      width: 595,
      height: 842,
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              'Relatório Final',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Data: $formatedData - Horário: $formatedHora",
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            )
          ]),
          const SizedBox(height: 1),
          const Divider(thickness: 1, color: Colors.black),
          const SizedBox(height: 16),
          const Text(
            'Relatório gerado com base nas escolhas do Segmento/Regime tributário informado:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('Cliente: ${result.cliente}'),
          Text('Segmento: ${result.segmento?.nome ?? "N/A"}'),
          Text('Regime Tributário: ${result.documento?.nome ?? "N/A"}'),
          const SizedBox(height: 20),
          const Text(
            'Documentos requeridos:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 10),
          if (result.docsNecessarios != null)
            ...result.docsNecessarios!.map((doc) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(fontSize: 14),
                    ),
                    Expanded(
                      child: Text(
                        doc,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                )),
          const SizedBox(height: 20),
          const Text(
            'Teses Consolidadas:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 10),
          if (result.teses != null)
            ...result.teses!.map(
              (tese) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(
                      tese.descricao ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buttonPrint(Result? result) {
  return BlocBuilder<ProjectCubit, ProjectState>(
    builder: (context, state) {
      final cubit = context.read<ProjectCubit>();
      return ButtonApp(
        text: 'Salvar PDF',
        icon: Icons.print,
        textColor: ThemeUtils.primaryColor,
        onPressed: () async {
          cubit.printResult(result!);
        },
      );
    },
  );
}

Widget _buttonDelete() {
  return BlocBuilder<ProjectCubit, ProjectState>(
    builder: (context, state) {
      final cubit = context.read<ProjectCubit>();
      return ButtonApp(
        text: 'Novo Relatório',
        icon: Icons.replay_circle_filled_sharp,
        textColor: Colors.red,
        onPressed: () {
          cubit.delete();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainScreen()));
        },
      );
    },
  );
}
