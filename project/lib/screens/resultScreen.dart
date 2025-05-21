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
import 'package:project/widgets/input_widget.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  late TextEditingController _inputControler;
  @override
  void initState() {
    _inputControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _inputControler.dispose();
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
            title: Column(
              children: [
                Center(
                  child: Image.asset('lib/images/logo1.png', height: 230),
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: ThemeUtils.backgroundColor,
                width: double.maxFinite,
                padding: const EdgeInsets.all(12.0),
                child: const Center(
                  child: Text(
                    'Exemplo Visualização do PDF',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: ThemeUtils.backgroundColor,
                  child: state.hasObs
                      ? contentEdit(context, state.result)
                      : content(state.result),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            color: ThemeUtils.backgroundColor,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttonDelete(),
                const SizedBox(width: 30),
                _buttonPrint(state.result)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget contentEdit(BuildContext context, Result? result) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      pdf(result),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                SizedBox(
                  height: double.infinity,
                  width: 500,
                  child: Card(
                      elevation: 20,
                      color: ThemeUtils.backgroundColor,
                      child: addObsContainer(context, result)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addObsContainer(BuildContext context, Result? result) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Digite as Observações do Relatório',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Input(
                    sizeFont: 14,
                    border: const UnderlineInputBorder(),
                    value: state.obs,
                    controller: _inputControler,
                    onChanged: (value) {
                      cubit.setObs(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget content(Result? result) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: ThemeUtils.backgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      pdf(result),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget pdf(Result? result) {
    final data = DateTime.now();
    final formatedData = DateFormat('dd/MM/yyyy').format(data);
    final formatedHora = DateFormat('HH:mm').format(data);

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        // final c = context.read<ProjectCubit>();
        return Center(
          child: Container(
            width: 595,
            height: 842,
            color: Colors.white,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Relatório Final',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Data: $formatedData - Horário: $formatedHora",
                        style: const TextStyle(
                            fontSize: 12, fontStyle: FontStyle.italic),
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
                Text('Cliente: ${result!.cliente}'),
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
                              _doc(doc),
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
                          child: Text('${tese.id}- ${tese.descricao}',
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                if (state.hasObs)
                  const Text(
                    'Observações:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                if (state.hasObs) Text('${state.obs}')
              ],
            ),
          ),
        );
      },
    );
  }

  _doc(String doc) {
    int ano = DateTime.now().year - 5;
    if (doc == 'Balanço' || doc == 'DRE' || doc == 'Balancete') {
      return '$doc (válido após: $ano)';
    }
    return doc;
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
}
