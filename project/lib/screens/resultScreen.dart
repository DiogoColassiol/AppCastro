// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project/api/models/receita_model.dart';
import 'package:project/cubit/project_cubit.dart';
import 'package:project/cubit/project_state.dart';
import 'package:project/entity/documentos.dart';
import 'package:project/entity/segmentoss.dart';
import 'package:project/screens/mainScreen.dart';
import 'package:project/widgets/button_widget.dart';
import 'package:project/utils/theme_utils.dart';
import 'package:project/widgets/input_widget.dart';

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  final String nome;
  final Segmento segmento;
  final Documento documento;
  final ReceitaModel? api;

  const ResultScreen(
      {super.key,
      required this.nome,
      required this.segmento,
      required this.documento,
      this.api});

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
                  child: state.hasObs ? contentEdit(context) : content(),
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
                _buttonPrint(),
                const SizedBox(width: 30),
                _hasObs(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget contentEdit(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        var outros = widget.segmento.id == '7';
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      outros ? pdfOutros() : pdf(),
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
                      child: addObsContainer(context)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget addObsContainer(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Informe as Observações do Relatório',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Input(
                    border: const UnderlineInputBorder(),
                    value: state.obs,
                    controller: _inputControler,
                    onChanged: (value) async {
                      await cubit.setObs(value);
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

  Widget content() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        var outros = widget.segmento.id == '7';
        return Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: ThemeUtils.backgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: [outros ? pdfOutros() : pdf()],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget pdfOutros() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Container(
              width: 595,
              constraints: const BoxConstraints(minHeight: 842),
              color: Colors.white,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader('Relatório Final'),
                  const SizedBox(height: 1),
                  const Divider(thickness: 1, color: Colors.black),
                  const SizedBox(height: 16),
                  ..._buildInfoText(
                      'Relatório gerado com a escolha de "Outros"'),
                  const SizedBox(height: 10),
                  ..._buildClientAndSeg(),
                  const SizedBox(height: 20),
                  ..._buildDocsNedded(),
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
                  if (state.hasObs)
                    Text(
                      '${state.obs}',
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pdf() {
    final data = DateTime.now();
    final formatedData = DateFormat('dd/MM/yyyy').format(data);
    final formatedHora = DateFormat('HH:mm').format(data);
    final hasApi = widget.api != null ? true : false;

    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final c = context.read<ProjectCubit>();
        final teses = c.searchTeses(widget.segmento, widget.documento);
        final docsNeed = c.searchDocs(teses, false);
        return Center(
          child: SingleChildScrollView(
            child: Container(
              width: 595,
              constraints: const BoxConstraints(minHeight: 842),
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
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  const Divider(thickness: 1, color: Colors.black),
                  const SizedBox(height: 16),
                  const Text(
                    'Relatório gerado com base nas escolhas do Segmento/Regime tributário informado:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Cliente: ${hasApi ? widget.api!.nome : widget.nome}'),
                  if (hasApi) Text('Nome fantasia: ${widget.api!.fantasia}'),
                  Text('Segmento: ${widget.segmento.nome ?? "N/A"}'),
                  if (hasApi) Text('Data de abertura: ${widget.api!.abertura}'),
                  if (hasApi) Text('Situação: ${widget.api!.situacao}'),
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
                  ...docsNeed.map((doc) => Row(
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
                  ...teses.map(
                    (tese) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 14)),
                        Expanded(
                          child: Text(
                            '${tese.id}- ${tese.descricao}',
                            style: const TextStyle(fontSize: 12),
                          ),
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
                  if (state.hasObs)
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${state.obs}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildHeader(String? title) {
    final data = DateTime.now();
    final formatedData = DateFormat('dd/MM/yyyy').format(data);
    final formatedHora = DateFormat('HH:mm').format(data);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? 'Relatório Final',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Data: $formatedData - Horário: $formatedHora",
          style: const TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  _buildInfoText(String text) {
    return [
      Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      )
    ];
  }

  _buildClientAndSeg() {
    final hasApi = widget.api != null ? true : false;
    return [
      Text('Cliente: ${hasApi ? widget.api!.nome : widget.nome}'),
      if (hasApi) Text('Nome fantasia: ${widget.api!.fantasia}'),
      if (hasApi) Text('Data de abertura: ${widget.api!.abertura}'),
      if (hasApi) Text('Situação: ${widget.api!.situacao}'),
      Text('Segmento: ${widget.segmento.nome ?? "N/A"}'),
      if (widget.segmento.id != '7')
        Text('Regime Tributário: ${widget.documento.nome ?? "N/A"}')
    ];
  }

  List<Widget> _buildDocsNedded() {
    final c = context.read<ProjectCubit>();

    final docsNeed = c.searchDocs([], true);
    List<Widget> widgets = [
      const Text(
        'Documentos requeridos:',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      const SizedBox(height: 10),
      ...docsNeed.map((doc) => Row(
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
    ];
    return widgets;
  }

  _doc(String doc) {
    int ano = DateTime.now().year - 5;
    if (doc == 'Balanço' || doc == 'DRE' || doc == 'Balancete') {
      return '$doc (válido após: $ano)';
    }
    return doc;
  }

  Widget _buttonPrint() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();

        return ButtonApp(
          text: 'Salvar PDF',
          icon: Icons.print,
          textColor: ThemeUtils.primaryColor,
          onPressed: () async {
            await cubit.printResult(
                widget.nome, widget.segmento, widget.documento);
          },
        );
      },
    );
  }

  Widget _hasObs() {
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        final cubit = context.read<ProjectCubit>();
        return Row(
          children: [
            ButtonApp(
              text: state.hasObs ? 'Com Observações' : 'Sem Observações',
              color: ThemeUtils.primaryColor,
              onPressed: () {
                if (state.hasObs == false) {
                  cubit.setObs('');
                }
                cubit.checkObs(!state.hasObs);
              },
              icon: state.hasObs
                  ? Icons.comment_outlined
                  : Icons.comments_disabled_outlined,
            )
          ],
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
